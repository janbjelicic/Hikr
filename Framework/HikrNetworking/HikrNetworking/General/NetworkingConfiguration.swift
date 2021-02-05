//
//  NetworkingConfiguration.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 31/01/2021.
//

import Foundation

public struct NetworkingConfiguration {
    
    private let authorizationGateway: AuthorizationGatewayProtocol
    
    public init() {
        let networkSession = NetworkSession()
        
        authorizationGateway = AuthorizationGateway(networkSession: networkSession)
    }
    
}
