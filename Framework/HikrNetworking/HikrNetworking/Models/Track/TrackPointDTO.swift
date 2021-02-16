//
//  TrackPointDTO.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 16/02/2021.
//

import CoreLocation
import Foundation

public class TrackPointDTO {
    
    public var coordinate: CLLocationCoordinate2D
    public var elevation: Double
    
    public init(coordinate: CLLocationCoordinate2D, elevation: Double) {
        self.coordinate = coordinate
        self.elevation = elevation
    }
    
}
