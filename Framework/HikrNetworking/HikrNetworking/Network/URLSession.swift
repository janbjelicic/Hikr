//
//  URLSession.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 18/02/2021.
//

import Foundation
import Combine

extension URLSession {
    
    func erasedDataTaskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        dataTaskPublisher(for: request)
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
    
}
