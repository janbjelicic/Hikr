//
//  TrackMetadataDTO.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 16/02/2021.
//

import Foundation
import MapKit

public class TrackMetadataDTO {
    
    #warning("Find appropriate class that defines a map bounds")
    let bounds: CGRect
    
    public init(bounds: CGRect) {
        self.bounds = bounds
    }
    
}

extension TrackMetadataDTO {
    
    public static var example = TrackMetadataDTO(bounds: CGRect(x: 45.9015740, y: 15.9825150, width: 45.8700780, height: 15.9473570))
    
}
