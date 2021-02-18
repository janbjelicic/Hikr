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
    
    public func getRoutes() -> AnyPublisher<[Route], Error> {
        let routesData = RoutesRequest()
        return routesGateway.get(routesData: routesData)
            .tryMap {
                let routes = $0.map { route in
                    Route(dto: route)
                }
                return routes
            }.eraseToAnyPublisher()
    }
    
}
