//
//  LocationManager.swift
//  Hikr
//
//  Created by Jan Bjelicic on 15/02/2021.
//

import Combine
import CoreLocation
import Foundation
import HikrNetworking

class LocationManager: NSObject, ObservableObject {
    
    private let locationManager = CLLocationManager()
    private (set) var currentLocation: CLLocation?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func areLocationServicesEnabled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            @unknown default:
                break
            }
        }
        return false
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.accuracyAuthorization {
        case .fullAccuracy:
            Logger.business.log("You have increased accuracy to full accuracy in the app!", osLogType: .info)
        case .reducedAccuracy:
            Logger.business.log("You have reduced accuracy to reduced accuracy in the app!", osLogType: .info)
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
}
