//
//  RoutesRequest.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 17/02/2021.
//

import Foundation

public struct RoutesRequest: Codable {
    
    public init() { }
    
}

extension RoutesRequest: NetworkRequestProtocol {
    public var path: String {
        "routes"
    }

    public var method: HTTPVerb {
        .get
    }

    public var headers: [String: String]? {
        return nil
    }

    public var parameters: [String: Any]? {
        return nil
    }

    public var requestType: RequestType {
        return .data
    }

    public var responseType: ResponseType {
        return .json
    }
}
