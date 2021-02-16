//
//  TrackDTO.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 16/02/2021.
//

import Foundation

public class TrackDTO {
    
    var name: String
    var points: [TrackPointDTO]
    
    public init(name: String, points: [TrackPointDTO]) {
        self.name = name
        self.points = points
    }
    
}
