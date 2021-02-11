//
//  TokenService.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 05/02/2021.
//

import Foundation

public protocol TokenServiceProtocol {
    
    func getAccessToken() -> String
    func getRefreshToken() -> String
    func saveTokenData(accessToken: String, refreshToken: String)
    func deleteTokenData() -> Bool
    
}

public struct TokenService: TokenServiceProtocol {
    
    private let keychainStorage: KeychainStorageProtocol
    private let accessTokenKey = "accessToken"
    private let refreshTokenKey = "refreshToken"
    
    init(keychainStorage: KeychainStorageProtocol) {
        self.keychainStorage = keychainStorage
    }
    
    public func getAccessToken() -> String {
        return ""
    }
    
    public func getRefreshToken() -> String {
        return ""
    }
    
    public func saveTokenData(accessToken: String, refreshToken: String) {
        
    }
    
    public func deleteTokenData() -> Bool {
        return true
    }
    
}
