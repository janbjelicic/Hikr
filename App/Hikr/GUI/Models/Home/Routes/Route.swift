//
//  Route.swift
//  Hikr
//
//  Created by Jan Bjelicic on 17/02/2021.
//

import Foundation
import MapKit

struct Route: Identifiable {
    
    let id: String
    let name: String
    let pathToGpxFile: String
    let polyLine: MKPolyline?
    
}
