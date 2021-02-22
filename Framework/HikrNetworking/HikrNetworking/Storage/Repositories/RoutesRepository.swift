//
//  RoutesRepository.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 19/02/2021.
//

import Foundation
import CoreData

protocol RoutesRepositoryProtocol {
    
    func getRoutes() -> [Route]?
    func createRoute(_ routeDTO: RouteDTO) -> Route
    func save()
    
}

class RoutesRepository: RoutesRepositoryProtocol {
    
    private let cacheTime = 60
    
    private let dataManager: DataManagerProtocol
    private var lastSaved: Date?
    
    init(dataManager: DataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    func getRoutes() -> [Route]? {
        guard let lastSaved = lastSaved, lastSaved.addingTimeInterval(60) > Date() else { return nil }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Route.self))
        return dataManager.fetch(fetchRequest) as? [Route]
    }
    
    func createRoute(_ routeDTO: RouteDTO) -> Route {
        let route = dataManager.createEntity(name: String(describing: Route.self)) as! Route
        
        route.id = routeDTO.id
        route.name = routeDTO.nameText
        route.pathToGpxFile = routeDTO.pathToGpxFile
        return route
    }
    
    func save() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Route.self))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        dataManager.delete(deleteRequest)
        
        lastSaved = Date()
        dataManager.save()
    }
    
}

