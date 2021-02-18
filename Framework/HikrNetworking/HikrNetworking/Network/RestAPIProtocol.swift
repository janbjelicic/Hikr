//
//  RestAPI.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 18/02/2021.
//

import Foundation
import Combine

public protocol RestAPIProtocol {
    
    var baseUrl: String { get }
    var urlSession: URLSession { get }
    
    func get(endpoint: String) -> AnyPublisher<(data: Data, response: URLResponse), Error>
    
}

public class RestAPI: RestAPIProtocol {
    
    public var baseUrl: String { "http://localhost:8080/v1/" }
    public var urlSession: URLSession { URLSession.shared }
    
    public func get(endpoint: String) -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        guard let url = URL(string: baseUrl)?.appendingPathComponent(endpoint) else {
            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: API.URLError.unableToCreateUrl).eraseToAnyPublisher()
        }
        let request = URLRequest(url: url)
        return createPublisher(for: request)
    }
 
    public func put(endpoint: String, data: Data?) -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        guard let url = URL(string: baseUrl)?.appendingPathComponent(endpoint) else {
            return Fail<URLSession.DataTaskPublisher.Output, Error>(error: API.URLError.unableToCreateUrl).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = data
        return createPublisher(for: request)
    }
    
    private func createPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        Just(request).setFailureType(to: Error.self)
            .flatMap { request -> AnyPublisher<(data: Data, response: URLResponse), Error> in
                return self.urlSession.erasedDataTaskPublisher(for: request)
            }.eraseToAnyPublisher()
    }
    
}

