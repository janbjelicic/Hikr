//
//  BaseAPI.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 18/02/2021.
//

import Foundation

public struct APIError {
    enum URL: Error {
        case unableToCreateUrl
    }
}

public enum APIEnvironment {
    
    case development
    case production
    
    var baseURL: String {
        switch self {
        case .development:
            return "http://localhost:8080/v1/"
        case .production:
            return "http://46.101.141.183/v1/"
        }
    }
    
}
