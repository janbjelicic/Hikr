//
//  QuickActionService.swift
//  Hikr
//
//  Created by Jan Bjelicic on 23/02/2021.
//

import UIKit

protocol QuickActionServiceProtocol {
    
    func setup()
    func saveShortcutItem(_ shortcutItem: UIApplicationShortcutItem?)
    func getShortcutItem() -> UIApplicationShortcutItem?
    @discardableResult
    func handleShortcutItem(_ shortcutItem: UIApplicationShortcutItem?) -> Bool
    
}

class QuickActionService: QuickActionServiceProtocol {
    
    // MARK: - Static actions
    private let openProfileShortcut = "com.allmighty.Hikr.openProfile"
    
    // MARK: - Dynamic actions
    private let dynamicShortcut = "com.allmighty.Hikr.dynamic"
    
    private var savedShortcutItem: UIApplicationShortcutItem?
    
    /// Add dynamic quick actions.
    func setup() {
        UIApplication.shared.shortcutItems = [
            UIApplicationShortcutItem(type: dynamicShortcut,
                                      localizedTitle: "Dynamic quick action",
                                      localizedSubtitle: nil,
                                      icon: UIApplicationShortcutIcon(systemImageName: "star.fill"),
                                      userInfo: nil)
        ]
    }
    
    func saveShortcutItem(_ shortcutItem: UIApplicationShortcutItem?) {
        savedShortcutItem = shortcutItem
    }
    
    func getShortcutItem() -> UIApplicationShortcutItem? {
        return savedShortcutItem
    }
    
    @discardableResult
    func handleShortcutItem(_ shortcutItem: UIApplicationShortcutItem?) -> Bool {
        if let shortcutItem = shortcutItem, shortcutItem.type == openProfileShortcut {
            Logger.business.log("Open profile was triggered!", osLogType: .debug)
        }
        savedShortcutItem = nil
        return true
    }
    
}
