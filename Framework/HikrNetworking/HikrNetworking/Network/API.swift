//
//  BaseAPI.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 18/02/2021.
//

import Foundation

public enum APIError: Error {
    case unableToCreateUrl
    case noData
    case invalidResponse
    case badRequest(String?)
    case serverError(String?)
    case parseError(String?)
    case unknown
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