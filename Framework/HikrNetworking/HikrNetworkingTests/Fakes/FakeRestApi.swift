//
//  FakeRestApi.swift
//  HikrNetworkingTests
//
//  Created by Jan Bjelicic on 25/02/2021.
//

import Foundation
import Combine
@testable import HikrNetworking

public class FakeRestApi: RestAPIProtocol {
    
    public var path: String?
    public var method: HTTPVerb?
    
    public func execute(networkRequest: NetworkRequestProtocol) -> AnyPublisher<Any, Error> {
        path = networkRequest.path
        method = networkRequest.method
        
        // Empty dictionary -> empty json object.
        return Just([:])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
        
    
}
