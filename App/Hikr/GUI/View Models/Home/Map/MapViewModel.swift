//
//  MapViewModel.swift
//  Hikr
//
//  Created by Jan Bjelicic on 15/02/2021.
//

import Foundation

class MapViewModel: ObservableObject {
    
    private let locationManager: LocationManager
    
    init() {
        self.locationManager = LocationManager()
    }
    
    func didUserEnableLocation() -> Bool {
        return locationManager.areLocationServicesEnabled()
    }
    
}
