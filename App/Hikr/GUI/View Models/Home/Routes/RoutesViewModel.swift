//
//  RoutesViewModel.swift
//  Hikr
//
//  Created by Jan Bjelicic on 17/02/2021.
//

import Foundation
import Combine

class RoutesViewModel: ObservableObject {
    
    @Published var routes: [Route]
    
    private var cancellableSet = Set<AnyCancellable>()
    
    init(routes: [Route] = []) {
        self.routes = routes
    }
    
    func getRoutes() {
        AppManager.shared.getRoutesService().getRoutes()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                #warning("Show an error alert")
            }, receiveValue: { [weak self] routes in
                guard let self = self else { return }
                self.routes = routes
            })
            .store(in: &cancellableSet)
    }
    
    func downloadGPXFile() {
        
    }
    
}
