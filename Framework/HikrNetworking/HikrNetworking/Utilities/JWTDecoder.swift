//
//  JWTDecoder.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 05/02/2021.
//

import Foundation

public class JWTDecoder {
 
    public static let sharedInstance = JWTDecoder()
    
    public class func decodeJwtPart(_ value: String) -> [String: Any]? {
        if let bodyData = JWTDecoder.base64UrlDecode(value) {
            if let json = try? JSONSerialization.jsonObject(with: bodyData, options: []), let payload = json as? [String: Any] {
                return payload
            }
        }
        return nil
    }
    
    private class func base64UrlDecode(_ value: String) -> Data? {
        var base64 = value.replacingOccurrences(of: "-", with: "+").replacingOccurrences(of: "_", with: "/")
        let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
        let requiredLength = 4 * ceil(length / 4.0)
        let paddingLength = requiredLength - length
        if paddingLength > 0 {
            let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
            base64 += padding
        }
        return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }
    
}
