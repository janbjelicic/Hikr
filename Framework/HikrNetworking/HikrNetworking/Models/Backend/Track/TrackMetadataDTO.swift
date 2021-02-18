//
//  TrackMetadataDTO.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 16/02/2021.
//

import Foundation
import MapKit

public struct TrackMetadataDTO {
    
    public let bounds: MKMapRect
    
    public init(bounds: MKMapRect) {
        self.bounds = bounds
    }
    
}

extension TrackMetadataDTO {
    
    public static var example = TrackMetadataDTO(bounds: MKMapRect(x: 45.9015740, y: 15.9825150, width: 45.8700780, height: 15.9473570))
    
}
