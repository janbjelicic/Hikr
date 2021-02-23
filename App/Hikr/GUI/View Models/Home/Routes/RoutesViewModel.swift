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
    
    @Published var showErrorAlert: Bool = false
    
    private var cancellableSet = Set<AnyCancellable>()
    
    init(routes: [Route] = []) {
        self.routes = routes
    }
    
    func getRoutes(shouldRefresh: Bool = false) {
        AppManager.shared.getRoutesService().getRoutes(shouldRefresh: shouldRefresh)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure:
                    self.showErrorAlert = true
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] routes in
                guard let self = self else { return }
                self.routes = routes
            })
            .store(in: &cancellableSet)
    }
    
    func downloadGPXFile() {
        
    }
    
}
