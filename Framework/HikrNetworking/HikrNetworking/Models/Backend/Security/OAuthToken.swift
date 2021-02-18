//
//  OAuthToken.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 05/02/2021.
//

import Foundation

public class OAuthToken {
    
    private static let userIDKey = "userId"
    
    private static let tokenOffset: TimeInterval = 30
    
    public let token: String
    public private(set) var userID: String?
    
    private var header: [String: Any]?
    private var body: [String: Any]?
    private var signature: String?
    

    init(token: String) {
        self.token = token
        decode()
    }
    
    private func decode() {
        let parts = token.components(separatedBy: ".")
        
        if parts.count == 3 {
            header = JWTDecoder.decodeJwtPart(parts[0])
            body = JWTDecoder.decodeJwtPart(parts[1])
            signature = parts[2]
        } else {
            header = nil
            body = nil
            signature = nil
        }

        if let body = self.body {
            userID = body[OAuthToken.userIDKey] as? String
        } else {
            userID = nil
        }
    }
    
}
