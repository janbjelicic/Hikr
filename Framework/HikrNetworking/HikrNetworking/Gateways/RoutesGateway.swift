//
//  RoutesGateway.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 17/02/2021.
//

import Foundation

public protocol RoutesGatewayProtocol {
    
    func get(routesData: RoutesRequest, completion: @escaping (_ routes: [RouteDTO]) -> ())
    
}

public class RoutesGateway: RoutesGatewayProtocol {
    
    let networkSession: NetworkSessionProtocol
    
    public init(networkSession: NetworkSessionProtocol) {
        self.networkSession = networkSession
    }
    
    public func get(routesData: RoutesRequest, completion: @escaping (_ routes: [RouteDTO]) -> ()) {
        let routesOperation = NetworkOperation(routesData)
        routesOperation.execute(networkSession: networkSession) { result in
            switch result {
            case .json(let json, _):
                if let json = json {
                    do {
                        let response = try JSONDecoder().decode([RouteDTO].self, withJSONObject: json)
                        completion(response)
                    } catch {
                        Logger.network.log("Error code while parsing", osLogType: .fault)
                    }
                } else {
                    Logger.network.log("No data from the backend.", osLogType: .info)
                }
            case .error(_, _):
                Logger.network.log("Error from the backend", osLogType: .info)
                default:
                    return
            }
        }
    }
    
}
