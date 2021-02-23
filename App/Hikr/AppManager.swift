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
    private let quickActionService: QuickActionServiceProtocol
    
    private init() {
        serviceCoordinator = ServiceCoordinator()
        quickActionService = QuickActionService()
    }
    
    public func getRoutesService() -> RoutesServiceProtocol {
        return serviceCoordinator.getRoutesService()
    }
    
    public func getQuickActionService() -> QuickActionServiceProtocol {
        return quickActionService
    }
    
}
