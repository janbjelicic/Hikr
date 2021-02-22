//
//  Route.swift
//  Hikr
//
//  Created by Jan Bjelicic on 17/02/2021.
//

import Foundation
import CoreData
import MapKit

@objc(Route)
public class Route: NSManagedObject {

}

extension Route: Identifiable {

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var pathToGpxFile: String

}

extension Route {
    
    public var polyLine: MKPolyline? {
        assertionFailure("Implement fetching from the local gpx file")
        return nil
    }
    
}
