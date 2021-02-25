//
//  RestAPI.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 18/02/2021.
//

import Foundation
import Combine

public protocol RestAPIProtocol {
    
    func execute(networkRequest: NetworkRequestProtocol) -> AnyPublisher<Any, Error>
    
}

public class RestAPI: NSObject, RestAPIProtocol {
    
    var urlSession: URLSession!

    public override convenience init() {
        #warning("Disable arbitrary loads for http. https doesn't work on localhost so do this only when you setup a dev environment on the server. It only makes sense to do this when you will have automated deployments for the server (dev and prod).")
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForResource = 30

        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 3
        queue.qualityOfService = .userInitiated

        self.init(configuration: sessionConfiguration, delegateQueue: queue)
    }

    public init(configuration: URLSessionConfiguration, delegateQueue: OperationQueue) {
        super.init()
        self.urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: delegateQueue)
    }

    deinit {
        urlSession.invalidateAndCancel()
        urlSession = nil
    }
    
    public func execute(networkRequest: NetworkRequestProtocol) -> AnyPublisher<Any, Error> {
        guard let request = networkRequest.urlRequest() else {
            return Fail<Any, Error>(error: APIError.badRequest("Invalid URL for: \(networkRequest)")).eraseToAnyPublisher()
        }
        return createPublisher(for: request)
    }
    
    private func createPublisher(for request: URLRequest) -> AnyPublisher<Any, Error> {
        Just(request).setFailureType(to: Error.self)
            .flatMap { request -> AnyPublisher<(data: Data, response: URLResponse), Error> in
                return self.urlSession.erasedDataTaskPublisher(for: request)
            }
            .flatMap { result -> AnyPublisher<Any, Error> in
                // Add here different types of handling depending on the request type
                return self.handleJsonTaskResponse(data: result.data, urlResponse: result.response)
            }
            .eraseToAnyPublisher()
    }
    
    private func handleJsonTaskResponse(data: Data?, urlResponse: URLResponse?) -> AnyPublisher<Any, Error> {
        // Check if the response is valid.
        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            return Fail<Any, Error>(error: APIError.invalidResponse).eraseToAnyPublisher()
        }
        // Verify the HTTP status code.
        let result = verify(data: data, urlResponse: urlResponse)
        switch result {
        case .success(let data):
            // Parse the JSON data
            let parseResult = parse(data: data as? Data)
            switch parseResult {
            case .success(let json):
                return Just(json).setFailureType(to: Error.self).eraseToAnyPublisher()
            case .failure(let error):
                return Fail<Any, Error>(error: error).eraseToAnyPublisher()
            }
        case .failure(let error):
            return Fail<Any, Error>(error: error).eraseToAnyPublisher()
        }
    }

    private func parse(data: Data?) -> Result<Any, Error> {
        guard let data = data else {
            return .failure(APIError.invalidResponse)
        }

        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            return .success(json)
        } catch (let exception) {
            return .failure(APIError.parseError(exception.localizedDescription))
        }
    }

    private func verify(data: Any?, urlResponse: HTTPURLResponse) -> Result<Any, Error> {
        switch urlResponse.statusCode {
        case 200...299:
            if let data = data {
                return .success(data)
            } else {
                return .failure(APIError.noData)
            }
        case 400...499:
            return .failure(APIError.badRequest(nil))
        case 500...599:
            return .failure(APIError.serverError(nil))
        default:
            return .failure(APIError.unknown)
        }
    }
    
}

extension RestAPI: URLSessionDelegate { }

