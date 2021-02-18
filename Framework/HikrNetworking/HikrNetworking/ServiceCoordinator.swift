//
//  ServiceCoordinator.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 18/02/2021.
//

import Foundation

public struct ServiceCoordinator {
    
    private var tokenService: TokenServiceProtocol
    private var routesService: RoutesServiceProtocol
    
    // TODO: Add dependency injection for testing purposes
    public init() {
        let keychainStorage = KeychainStorage()
        let restApi = RestAPI()
        
        self.tokenService = TokenService(keychainStorage: keychainStorage)
        let routesGateway = RoutesGateway(api: restApi)
        
        self.routesService = RoutesService(routesGateway: routesGateway)
    }
    
    public func getRoutesService() -> RoutesServiceProtocol {
        return routesService
    }
}
