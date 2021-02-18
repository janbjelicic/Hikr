//
//  TokenDTO.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 31/01/2021.
//

import Foundation

public struct TokenDTO: Codable {

    public var accessToken: String?
    public var expiresIn: Double?
    public var refreshExpiresIn: Double?
    public var refreshToken: String?
    public var tokenType: String?
    public var idToken: String?
    public var notBeforePolicy: Double?
    public var sessionState: String?

    public init(accessToken: String?,
                expiresIn: Double?,
                refreshExpiresIn: Double?,
                refreshToken: String?,
                tokenType: String?,
                idToken: String?,
                notBeforePolicy: Double?,
                sessionState: String?) {
        self.accessToken = accessToken
        self.expiresIn = expiresIn
        self.refreshExpiresIn = refreshExpiresIn
        self.refreshToken = refreshToken
        self.tokenType = tokenType
        self.idToken = idToken
        self.notBeforePolicy = notBeforePolicy
        self.sessionState = sessionState
    }

}
