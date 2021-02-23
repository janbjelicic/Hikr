//
//  BaseAPI.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 18/02/2021.
//

import Foundation

public enum APIError: Error {
    case noData
    case invalidResponse
    case badRequest(String?)
    case serverError(String?)
    case parseError(String?)
    case unknown
}

public enum ServerDestination: Int {
    case development = 0
    case production = 1
}

public protocol APIEnvironmentProtocol {
    static var apiServerDestination: String { get }
    static func baseUrl() -> String
}

public class APIEnvironment: APIEnvironmentProtocol {
    
    public static var apiServerDestination: String {
        return "api.server.destination"
    }
    
    public static func baseUrl() -> String {
        switch destination {
        case .development:
            return "http://localhost:8080/v1/"
        case .production:
            return "http://46.101.141.183/v1/"
        }
    }
    
    private static var destination: ServerDestination {
        return parseApiServerDestination()
    }
    
    private static func parseApiServerDestination() -> ServerDestination {
        #if DEBUG
        guard let destinationString = UserDefaults().dictionaryRepresentation()[apiServerDestination] as? String,
              let destinationValue = Int(destinationString),
              let destination = ServerDestination(rawValue: destinationValue) else {
                return .development
        }
        return destination
        #else
        return .production
        #endif
    }
    
}
