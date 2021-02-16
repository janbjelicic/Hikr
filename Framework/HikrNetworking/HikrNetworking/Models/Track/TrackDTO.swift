//
//  TrackDTO.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 16/02/2021.
//

import Foundation

public class TrackDTO {
    
    public var name: String
    public var points: [TrackPointDTO]
    
    public init(name: String, points: [TrackPointDTO]) {
        self.name = name
        self.points = points
    }
    
}
