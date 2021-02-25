//
//  RoutesGateway.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 17/02/2021.
//

import Foundation
import Combine

public protocol RoutesGatewayProtocol {
    
    func get(routesData: RoutesRequest) -> AnyPublisher<[RouteDTO], Error>
    
}

public class RoutesGateway: RoutesGatewayProtocol {
    
    let api: RestAPIProtocol

    public init(api: RestAPIProtocol) {
        self.api = api
    }
    
    public func get(routesData: RoutesRequest) -> AnyPublisher<[RouteDTO], Error> {
        api.execute(networkRequest: routesData)
            .tryMap {
                do {
                    let response = try JSONDecoder().decode([RouteDTO].self, withJSONObject: $0)
                    return response
                } catch {
                    Logger.network.log("Error code while parsing", osLogType: .fault)
                }
                return []
            }.eraseToAnyPublisher()
    }
    
}
