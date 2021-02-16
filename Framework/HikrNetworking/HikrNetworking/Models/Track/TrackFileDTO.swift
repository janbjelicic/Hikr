//
//  TrackFileDTO.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 16/02/2021.
//

import Foundation

public class TrackFileDTO {
    
    var metadata: TrackMetadataDTO
    var tracks: [TrackDTO]
    
    public init(metadata: TrackMetadataDTO, tracks: [TrackDTO]) {
        self.metadata = metadata
        self.tracks = tracks
    }
    
}
