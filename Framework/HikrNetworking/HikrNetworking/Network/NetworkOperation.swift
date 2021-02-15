//
//  NetworkOperation.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 31/01/2021.
//

import Foundation

enum OperationResult {
    case json(_ : Any?, _ : HTTPURLResponse?)
    case file(_ : URL?, _ : HTTPURLResponse?)
    case error(_ : Error?, _ : HTTPURLResponse?)
}

protocol NetworkOperationProtocol {
    associatedtype Output
    
    var request: NetworkRequestProtocol { get }
    
    func execute(networkSession: NetworkSessionProtocol, completion: @escaping (Output) -> Void) -> URLSessionTask?
    
    func cancel() -> Void
}

class NetworkOperation: NetworkOperationProtocol {
    typealias Output = OperationResult
    
    private var task: URLSessionTask?
    
    internal var request: NetworkRequestProtocol
    
    init(_ request: NetworkRequestProtocol) {
        self.request = request
    }
    
    func cancel() {
        task?.cancel()
    }
    
    func execute(networkSession: NetworkSessionProtocol, completion: @escaping (OperationResult) -> Void) -> URLSessionTask? {
        #warning("Find a better place for environment initialization, potentially make it shared and immutable, initialized on app startup")
        let environment = APIEnvironment()
        // Create a URL request.
        guard var urlRequest = request.urlRequest(with: environment) else {
            completion(.error(APIError.badRequest("Invalid URL for: \(request)"), nil))
            return nil
        }
        // Add the environment specific headers.
        environment.headers?.forEach({ (key: String, value: String) in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        })
        
        // Create a URLSessionTask to execute the URLRequest.
        var task: URLSessionTask?
        switch request.requestType {
        case .data:
            task = networkSession.dataTask(with: urlRequest, completionHandler: { [weak self] (data, urlResponse, error) in
                self?.handleJsonTaskResponse(data: data, urlResponse: urlResponse, error: error, completion: completion)
            })
        case .download:
            //            task = networkSession.downloadTask(request: urlRequest, progressHandler: request.progressHandler, completionHandler: { [weak self] (fileUrl, urlResponse, error) in
            //                self?.handleFileTaskResponse(fileUrl: fileUrl, urlResponse: urlResponse, error: error, completion: completion)
            //            })
            break
        case .upload:
            //            task = networkSession.uploadTask(with: urlRequest, from: URL(fileURLWithPath: ""), progressHandler: request.progressHandler, completion: { [weak self] (data, urlResponse, error) in
            //                self?.handleJsonTaskResponse(data: data, urlResponse: urlResponse, error: error, completion: completion)
            //            })
            break
        }
        task?.resume()
        
        return task
    }
    
    private func handleJsonTaskResponse(data: Data?, urlResponse: URLResponse?, error: Error?, completion: @escaping (OperationResult) -> Void) {
        // Check if the response is valid.
        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            completion(OperationResult.error(APIError.invalidResponse, nil))
            return
        }
        // Verify the HTTP status code.
        let result = verify(data: data, urlResponse: urlResponse, error: error)
        switch result {
        case .success(let data):
            // Parse the JSON data
            let parseResult = parse(data: data as? Data)
            switch parseResult {
            case .success(let json):
                DispatchQueue.main.async {
                    completion(OperationResult.json(json, urlResponse))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(OperationResult.error(error, urlResponse))
                }
            }
        case .failure(let error):
            DispatchQueue.main.async {
                completion(OperationResult.error(error, urlResponse))
            }
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
    
    private func verify(data: Any?, urlResponse: HTTPURLResponse, error: Error?) -> Result<Any, Error> {
        switch urlResponse.statusCode {
        case 200...299:
            if let data = data {
                return .success(data)
            } else {
                return .failure(APIError.noData)
            }
        case 400...499:
            return .failure(APIError.badRequest(error?.localizedDescription))
        case 500...599:
            return .failure(APIError.serverError(error?.localizedDescription))
        default:
            return .failure(APIError.unknown)
        }
    }
    
}
