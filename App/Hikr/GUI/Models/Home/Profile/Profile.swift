//
//  Profile.swift
//  Hikr
//
//  Created by Jan Bjelicic on 03/02/2021.
//

import Foundation

public struct Profile {
    
    public var name: String
    public var address: String
    public var phoneNumber: String
    public var bio: String
    
    static let example = Profile(name: "John",
                                 address: "Happy Street 1",
                                 phoneNumber: "+385192435244",
                                 bio: "I'm a software developer")
    
}
