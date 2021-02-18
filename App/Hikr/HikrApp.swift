//
//  HikrApp.swift
//  Hikr
//
//  Created by Jan Bjelicic on 27/01/2021.
//

import SwiftUI
#warning("Find a better way to include view objects")
@_exported import HikrNetworking

@main
struct HikrApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appConfig
    
    var body: some Scene {
        WindowGroup {
            HomeView()
            //AccountSetupView(state: .register)
        }
    }
    
}
