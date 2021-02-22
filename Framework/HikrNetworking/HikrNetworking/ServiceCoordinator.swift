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
    
    private var routesRepository: RoutesRepositoryProtocol
    
    // TODO: Add dependency injection for testing purposes
    public init() {
        let keychainStorage = KeychainStorage()
        let restApi = RestAPI()
        let dataManager = DataManager()
        
        self.tokenService = TokenService(keychainStorage: keychainStorage)
        let routesGateway = RoutesGateway(api: restApi)
        
        self.routesService = RoutesService(routesGateway: routesGateway, dataManager: dataManager)
        
        self.routesRepository = RoutesRepository(dataManager: dataManager)
    }
    
    public func getRoutesService() -> RoutesServiceProtocol {
        return routesService
    }
}
