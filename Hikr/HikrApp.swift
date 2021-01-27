//
//  HikrApp.swift
//  Hikr
//
//  Created by Jan Bjelicic on 27/01/2021.
//

import SwiftUI

@main
struct HikrApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
