//
//  GPXParser.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 16/02/2021.
//

import Foundation
import MapKit
import CoreLocation

enum GPXParserEvent {
    
    case none
    case metadata
    case bounds
    case track
    case name
    case trackPoint
    case elevation
    
    var name: String {
        switch self {
        case .none:
            return ""
        case .metadata:
            return "metadata"
        case .bounds:
            return "bounds"
        case .elevation:
            return "ele"
        case .track:
            return "trk"
        case .name:
            return "name"
        case .trackPoint:
            return "trkpt"
        }
    }
}

public protocol GPXParserProtocol {
    func parse(xmlData: Data)
    func getFile() -> TrackFileDTO?
}

public class GPXParser: NSObject, GPXParserProtocol {
    
    private let maxLatitudeAttributeName = "maxlat"
    private let maxLongitudeAttributeName = "maxlon"
    private let minLatitudeAttributeName = "minlat"
    private let minLongitudeAttributeName = "minlon"
    
    private let latitudeAttributeName = "lat"
    private let longitudeAttributeName = "lon"
    
    private var trackFile: TrackFileDTO?
    private var track: TrackDTO?
    private var trackPoint: TrackPointDTO?
    
    private var currentElement: GPXParserEvent = .none
    
    public func parse(xmlData: Data) {
        trackFile = TrackFileDTO(metadata: TrackMetadataDTO.example, tracks: [])
        
        let parser = XMLParser(data: xmlData)
        parser.delegate = self
        parser.parse()
    }
    
    public func getFile() -> TrackFileDTO? {
        return trackFile
    }
    
}

extension GPXParser: XMLParserDelegate {
    
    public func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {
        if elementName == GPXParserEvent.metadata.name,
           let minLatitude = attributeDict[minLatitudeAttributeName], let minLatitudeValue = Double(minLatitude),
           let minLongitude = attributeDict[minLongitudeAttributeName], let minLongitudeValue = Double(minLongitude),
           let maxLatitude = attributeDict[maxLatitudeAttributeName], let maxLatitudeValue = Double(maxLatitude),
           let maxLongitude = attributeDict[maxLongitudeAttributeName], let maxLongitudeValue = Double(maxLongitude) {
            trackFile?.metadata = TrackMetadataDTO(bounds: CGRect(x: minLatitudeValue, y: minLongitudeValue, width: maxLatitudeValue, height: maxLongitudeValue))
            currentElement = .metadata
        } else if elementName == GPXParserEvent.track.name {
            track = TrackDTO(name: "", points: [])
            currentElement = .track
        } else if elementName == GPXParserEvent.name.name {
            currentElement = .name
        } else if elementName == GPXParserEvent.trackPoint.name,
                  let latitude = attributeDict[latitudeAttributeName], let latitudeValue = Double(latitude),
                  let longitude = attributeDict[longitudeAttributeName], let longitudeValue = Double(longitude) {
            trackPoint = TrackPointDTO(coordinate: CLLocationCoordinate2D(latitude: latitudeValue, longitude: longitudeValue),
                                              elevation: 0.0)
            currentElement = .trackPoint
        } else if elementName == GPXParserEvent.elevation.name {
            currentElement = .elevation
        }
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        if currentElement == .name {
            track?.name = string
        }
        if currentElement == .elevation, let value = Double(string) {
            trackPoint?.elevation = value
        }
    }
    
    public func parser(_ parser: XMLParser,
                       didEndElement elementName: String,
                       namespaceURI: String?,
                       qualifiedName qName: String?) {
        if elementName == GPXParserEvent.track.name, let track = self.track {
            trackFile?.tracks.append(track)
        }
        if elementName == GPXParserEvent.trackPoint.name, let trackPoint = self.trackPoint {
            track?.points.append(trackPoint)
        }
        currentElement = .none
    }
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        print("Ended parsing yey!")
    }
    
}

class Parser {
    private let coordinateParser = CoordinatesParser()

    func parseCoordinates(fromGpxFile filePath: String) -> [CLLocationCoordinate2D]? {
        guard let data = FileManager.default.contents(atPath: filePath) else { return nil }
    
        coordinateParser.prepare()
    
        let parser = XMLParser(data: data)
        parser.delegate = coordinateParser

        let success = parser.parse()
    
        guard success else { return nil }
        return coordinateParser.coordinates
    }
}

class CoordinatesParser: NSObject, XMLParserDelegate {
    private(set) var coordinates = [CLLocationCoordinate2D]()

    func prepare() {
        coordinates = [CLLocationCoordinate2D]()
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        guard elementName == "trkpt" || elementName == "wpt" else { return }
        guard let latString = attributeDict["lat"], let lonString = attributeDict["lon"] else { return }
        guard let lat = Double(latString), let lon = Double(lonString) else { return }
        guard let latDegrees = CLLocationDegrees(exactly: lat), let lonDegrees = CLLocationDegrees(exactly: lon) else { return }

        coordinates.append(CLLocationCoordinate2D(latitude: latDegrees, longitude: lonDegrees))
    }
}
