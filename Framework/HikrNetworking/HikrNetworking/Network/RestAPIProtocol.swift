//
//  RestAPI.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 18/02/2021.
//

import Foundation
import Combine

public protocol RestAPIProtocol {
    
    var urlSession: URLSession { get }
    
    func execute(networkRequest: NetworkRequestProtocol) -> AnyPublisher<(data: Data, response: URLResponse), Error>
    
}

public class RestAPI: RestAPIProtocol {
    
    public var urlSession: URLSession { URLSession.shared }
    
    public func execute(networkRequest: NetworkRequestProtocol) -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        #warning("Setup environment in the network setup itself")
        guard let request = networkRequest.urlRequest(with: .development) else {
            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: APIError.URL.unableToCreateUrl).eraseToAnyPublisher()
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

