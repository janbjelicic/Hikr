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
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            HomeView()
            //AccountSetupView(state: .register)
        }
        .onChange(of: scenePhase) { newPhase in
            switch newPhase {
            case .active:
                Logger.ui.log("App is active!", osLogType: .debug)
                let quickActionService = AppManager.shared.getQuickActionService()
                quickActionService.handleShortcutItem(quickActionService.getShortcutItem())
            case .inactive:
                Logger.ui.log("App is inactive!", osLogType: .debug)
            case .background:
                Logger.ui.log("App is in the backgroud!", osLogType: .debug)
                AppManager.shared.getQuickActionService().setup()
            @unknown default:
                break
            }
        }
    }
    
}
