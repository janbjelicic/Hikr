//
//  BackendAPI.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 31/01/2021.
//

import Foundation
import Combine

public enum APIError: Error {
    case noData
    case invalidResponse
    case badRequest(String?)
    case serverError(String?)
    case parseError(String?)
    case unknown
}

public protocol NetworkSessionProtocol {
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask?
    
}

public class NetworkSession: NSObject {
    
    var session: URLSession!
    
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
        self.session = URLSession(configuration: configuration, delegate: self, delegateQueue: delegateQueue)
    }
    
    deinit {
        session.invalidateAndCancel()
        session = nil
    }
    
}

extension NetworkSession: NetworkSessionProtocol {
    
    public func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            completionHandler(data, response, error)
        }
        return dataTask
    }
    
}

extension NetworkSession: URLSessionDelegate {
    
}
