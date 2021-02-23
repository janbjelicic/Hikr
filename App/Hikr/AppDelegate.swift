//
//  AppDelegate.swift
//  Hikr
//
//  Created by Jan Bjelicic on 03/02/2021.
//

import UIKit
import Firebase
import HikrNetworking

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        AppManager.shared.getQuickActionService().saveShortcutItem(options.shortcutItem)
        
        let sceneConfiguration = UISceneConfiguration(name: "Custom scene configuration",
                                                      sessionRole: connectingSceneSession.role)
        sceneConfiguration.delegateClass = CustomSceneDelegate.self
        return sceneConfiguration
    }
    
}

class CustomSceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    func windowScene(_ windowScene: UIWindowScene,
                     performActionFor shortcutItem: UIApplicationShortcutItem,
                     completionHandler: @escaping (Bool) -> Void) {
        let handled = AppManager.shared.getQuickActionService().handleShortcutItem(shortcutItem)
        completionHandler(handled)
    }
    
}
