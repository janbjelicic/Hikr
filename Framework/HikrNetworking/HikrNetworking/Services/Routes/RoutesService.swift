//
//  RoutesService.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 18/02/2021.
//

import Foundation
import Combine

public protocol RoutesServiceProtocol {
    
    func getRoutes(shouldRefresh: Bool) -> AnyPublisher<[Route], Error>
    
}

// Handle caching, core data cloud kit
public struct RoutesService: RoutesServiceProtocol {
    
    let routesGateway: RoutesGatewayProtocol
    let routesRepository: RoutesRepositoryProtocol
    
    public func getRoutes(shouldRefresh: Bool) -> AnyPublisher<[Route], Error> {
        // If cache is still valid fetch from core data.
        if !shouldRefresh, let routes = routesRepository.getRoutes(), routes.count > 0 {
            return Just(routes)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        let routesData = RoutesRequest()
        
        return routesGateway.get(routesData: routesData)
            .tryMap {
                let routes = $0.map { route in
                    routesRepository.createRoute(route)
                }
                routesRepository.save()
                return routes
            }.eraseToAnyPublisher()
    }
    
}
