//
//  APIEnvironment.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 31/01/2021.
//

import Foundation

public protocol APIEnvironmentProtocol {
    var headers: [String: String]? { get }
    var baseURL: String { get }
}

enum APIEnvironment: APIEnvironmentProtocol {
    case development
    case production

    var headers: [String: String]? {
        switch self {
        case .development:
            return [
                "Content-Type" : "application/json"
            ]
        case .production:
            return [:]
        }
    }

    var baseURL: String {
        switch self {
        case .development:
            return "http://localhost:8080/"
        case .production:
            return "http://46.101.141.183/"
        }
    }
}
