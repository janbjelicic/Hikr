//
//  ProfileDTO.swift
//  HikrNetworking
//
//  Created by Jan Bjelicic on 02/02/2021.
//

import Foundation

public struct ProfileDTO: Codable {
    
    public var name: String
    public var title: String
    public var bio: String
    
    public init(name: String, title: String, bio: String) {
        self.name = name
        self.title = title
        self.bio = bio
    }
    
}
