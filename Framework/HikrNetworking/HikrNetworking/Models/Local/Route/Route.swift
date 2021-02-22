//
//  Route.swift
//  Hikr
//
//  Created by Jan Bjelicic on 17/02/2021.
//

import Foundation
import CoreData
import MapKit

//public struct Route: Identifiable {
//
//    public let id: String
//    public let name: String
//    public let pathToGpxFile: String
//
//}

extension Route {
    
    public init(dto: RouteDTO) {
        self.id = dto.id
        self.name = dto.nameText
        self.pathToGpxFile = dto.pathToGpxFile
    }
    
    public var polyLine: MKPolyline? {
        assertionFailure("Implement fetching from the local gpx file")
        return nil
    }
    
}
