//
//  HikrApp.swift
//  Hikr
//
//  Created by Jan Bjelicic on 27/01/2021.
//

import SwiftUI

@main
struct HikrApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appConfig
    
    var body: some Scene {
        WindowGroup {
            AccountSetupView(state: .register)
        }
    }
    
}
