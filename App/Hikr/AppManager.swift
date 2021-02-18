//
//  AppManager.swift
//  Hikr
//
//  Created by Jan Bjelicic on 18/02/2021.
//

import Foundation
import HikrNetworking

class AppManager {
    
    static let shared = AppManager()
    
    private let serviceCoordinator: ServiceCoordinator
    
    private init() {
        serviceCoordinator = ServiceCoordinator()
    }
    
    public func getRoutesService() -> RoutesServiceProtocol {
        return serviceCoordinator.getRoutesService()
    }
    
}
