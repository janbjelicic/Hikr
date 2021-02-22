//
//  RoutesService.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 18/02/2021.
//

import Foundation
import Combine

public protocol RoutesServiceProtocol {
    
    func getRoutes() -> AnyPublisher<[Route], Error>
    
}

// Handle caching, core data cloud kit
public struct RoutesService: RoutesServiceProtocol {
    
    let routesGateway: RoutesGatewayProtocol
    let dataManager: DataManagerProtocol
    
    public func getRoutes() -> AnyPublisher<[Route], Error> {
        // If cache is still valid fetch from core data.
        
        let routesData = RoutesRequest()
        
        return routesGateway.get(routesData: routesData)
            .tryMap {
                let routes = $0.map { route in
                    Route(dto: route)
                }
                // Save to core data
                dataManager.c
                return routes
            }.eraseToAnyPublisher()
    }
    
}
