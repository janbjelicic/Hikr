//
//  AppDelegate.swift
//  Hikr
//
//  Created by Jan Bjelicic on 03/02/2021.
//

import UIKit
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
}
