//
//  AuthorizationGateway.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 31/01/2021.
//

import Foundation
import Combine

public protocol AuthorizationGatewayProtocol {
    
    func login(loginData: LoginRequest)
    
}

public struct AuthorizationGateway: AuthorizationGatewayProtocol {
    
//    let networkSession: NetworkSessionProtocol
//    
//    public init(networkSession: NetworkSessionProtocol) {
//        self.networkSession = networkSession
//    }
    
    public func login(loginData: LoginRequest) {
//        let loginOperation = NetworkOperation(loginData)
//        loginOperation.execute(networkSession: networkSession) { result in
//            print(result)
//        }
    }
    
}
