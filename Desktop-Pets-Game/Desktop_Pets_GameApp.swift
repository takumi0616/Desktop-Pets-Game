//
//  Desktop_Pets_GameApp.swift
//  Desktop-Pets-Game
//
//  Created by 髙須賀匠 on 2023/11/15.
//

import SwiftUI
import SwiftData

@main
struct Desktop_Pets_GameApp: App {
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
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
