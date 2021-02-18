//
//  APIEnvironment.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 31/01/2021.
//

import Foundation

public enum APIDestination {
    case development
    case production
}

public protocol APIEnvironmentProtocol {
    var testEnvironmentDevelopment: String { get }
    var testEnvironmentProduction: String { get }
    
    var headers: [String: String]? { get }
    var destination: APIDestination { get }
    func baseURL() -> String
}

public struct APIEnvironment: APIEnvironmentProtocol { }

extension APIEnvironmentProtocol {
    
    public var testEnvironmentDevelopment: String { return "" }
    public var testEnvironmentProduction: String { return "" }

    public var headers: [String: String]? {
        return [
            "Content-Type" : "application/json"
        ]
    }
    
    public var destination: APIDestination {
//        guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
//            return .production
//        }
//        let environmentVariables = ProcessInfo.processInfo.environment
        return .development
    }

    public func baseURL() -> String {
        switch destination {
        case .development:
            return "http://localhost:8080/v1/"
        case .production:
            return "http://46.101.141.183/v1/"
        }
    }
    
}
