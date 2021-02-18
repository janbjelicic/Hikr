//
//  RestAPI.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 18/02/2021.
//

import Foundation
import Combine

public protocol RestAPIProtocol {
    
    func execute(networkRequest: NetworkRequestProtocol) -> AnyPublisher<(data: Data, response: URLResponse), Error>
    
}

public class RestAPI: NSObject, RestAPIProtocol {
    
    var urlSession: URLSession!

    public override convenience init() {
        #warning("Disable arbitrary loads for http")
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForResource = 30
        sessionConfiguration.waitsForConnectivity = true

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
    
    public func execute(networkRequest: NetworkRequestProtocol) -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        #warning("Setup environment in the network setup itself")
        guard let request = networkRequest.urlRequest(with: .development) else {
            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: APIError.unableToCreateUrl).eraseToAnyPublisher()
        }
        return createPublisher(for: request)
    }
    
    private func createPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        Just(request).setFailureType(to: Error.self)
            .flatMap { request -> AnyPublisher<(data: Data, response: URLResponse), Error> in
                return self.urlSession.erasedDataTaskPublisher(for: request)
            }.eraseToAnyPublisher()
    }
    
}

extension RestAPI: URLSessionDelegate { }

