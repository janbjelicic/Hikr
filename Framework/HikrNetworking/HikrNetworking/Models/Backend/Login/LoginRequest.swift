//
//  LoginRequest.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 03/02/2021.
//

import Foundation

public struct LoginRequest: Codable {
    
    let email: String
    let password: String
    
    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
}

//extension LoginRequest: NetworkRequestProtocol {
//    public var path: String {
//        "login"
//    }
//
//    public var method: HTTPVerb {
//        .post
//    }
//
//    public var headers: [String: String]? {
//        return nil
//    }
//
//    public var parameters: [String: Any]? {
//        self.jsonObject
//    }
//
//    public var requestType: RequestType {
//        return .data
//    }
//
//    public var responseType: ResponseType {
//        return .json
//    }
//}
