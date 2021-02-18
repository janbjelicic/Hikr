//
//  RoutesGateway.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 17/02/2021.
//

import Foundation
import Combine

public protocol RoutesGatewayProtocol {
    
//    func get(routesData: RoutesRequest, completion: @escaping (_ routes: [RouteDTO]) -> ())
    func get(routesData: RoutesRequest) -> AnyPublisher<[RouteDTO], Error>
    
}

public class RoutesGateway: RoutesGatewayProtocol {
    
    let api: RestAPIProtocol

    public init(api: RestAPIProtocol) {
        self.api = api
    }
    
//    public func get(routesData: RoutesRequest, completion: @escaping (_ routes: [RouteDTO]) -> ()) {
//        api.get(endpoint: "routes")
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .failure:
//                    Logger.network.log("Error from the backend", osLogType: .info)
//                case .finished:
//                    Logger.network.log("Error from the backend", osLogType: .info)
//                }
//            }) { value in
//                do {
//                    let json = try JSONSerialization.jsonObject(with: value.data, options: .mutableContainers)
//                    let response = try JSONDecoder().decode([RouteDTO].self, withJSONObject: json)
//                    completion(response)
//                } catch {
//                    Logger.network.log("Error code while parsing", osLogType: .fault)
//                }
////                XCTAssertEqual((value.response as? HTTPURLResponse)?.statusCode, 200)
////                XCTAssertEqual(String(data: value.data, encoding: .utf8), String(data: json, encoding: .utf8))
//            }.store(in: &cancellableSet)
//    }
    public func get(routesData: RoutesRequest) -> AnyPublisher<[RouteDTO], Error> {
        api.get(endpoint: "routes")
            .tryMap {
                do {
                    let json = try JSONSerialization.jsonObject(with: $0.data, options: .mutableContainers)
                    let response = try JSONDecoder().decode([RouteDTO].self, withJSONObject: json)
                    return response
                } catch {
                    Logger.network.log("Error code while parsing", osLogType: .fault)
                }
                return []
            }.eraseToAnyPublisher()
    }
    
//    public func get(routesData: RoutesRequest, completion: @escaping (_ routes: [RouteDTO]) -> ()) {
//        let routesOperation = NetworkOperation(routesData)
//        routesOperation.execute(networkSession: networkSession) { result in
//            switch result {
//            case .json(let json, _):
//                if let json = json {
//                    do {
//                        let response = try JSONDecoder().decode([RouteDTO].self, withJSONObject: json)
//                        completion(response)
//                    } catch {
//                        Logger.network.log("Error code while parsing", osLogType: .fault)
//                    }
//                } else {
//                    Logger.network.log("No data from the backend.", osLogType: .info)
//                }
//            case .error(_, _):
//
//                default:
//                    return
//            }
//        }
//    }
    
}
