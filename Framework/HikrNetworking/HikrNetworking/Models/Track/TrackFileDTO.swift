//
//  TrackFileDTO.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 16/02/2021.
//

import Foundation

public struct TrackFileDTO {
    
    public var metadata: TrackMetadataDTO
    public var tracks: [TrackDTO]
    
    public init(metadata: TrackMetadataDTO, tracks: [TrackDTO]) {
        self.metadata = metadata
        self.tracks = tracks
    }
    
}
