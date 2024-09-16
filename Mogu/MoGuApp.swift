//
//  MoGuApp.swift
//  MoGu
//
//  Created by MacBook Air on 13/09/24.
//

import SwiftUI
import SwiftData

@main
struct MoGuApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
//            ContentView()
            SummaryView()
        }
        .modelContainer(sharedModelContainer)
    }
}
