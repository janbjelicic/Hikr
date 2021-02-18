//
//  RoutesViewModel.swift
//  Hikr
//
//  Created by Jan Bjelicic on 17/02/2021.
//

import Foundation
import Combine
import HikrNetworking

class RoutesViewModel: ObservableObject {
    
    @Published var routes: [Route]
    private var routesDTO: [RouteDTO] = []
    
    init(routes: [Route] = []) {
        self.routes = routes
        getRoutes()
    }
    
    func getRoutes() {
        let routesGateway = RoutesGateway(networkSession: NetworkSession())
        let routesData = RoutesRequest()
        routesGateway.get(routesData: routesData) { [weak self] routes in
            guard let self = self else { return }
            self.routesDTO = routes
            print(routes)
        }
    }
    
    func downloadGPXFile() {
        
    }
    
}
