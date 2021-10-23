//
//  searchApp.swift
//  search
//
//  Created by Gert-Jan Vercauteren on 23/10/2021.
//

import SwiftUI

@main
struct searchApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
