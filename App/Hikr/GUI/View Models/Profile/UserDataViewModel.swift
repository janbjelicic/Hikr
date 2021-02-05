//
//  UserDataViewModel.swift
//  Hikr
//
//  Created by Jan Bjelicic on 02/02/2021.
//

import Foundation
import SwiftUI
import HikrNetworking

class UserDataViewModel: ObservableObject {
    
    @Binding var profile: Profile
    
    init(profile: Binding<Profile>) {
        self._profile = profile
    }
    
}
