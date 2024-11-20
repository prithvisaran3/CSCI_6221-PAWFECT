//
//  pawfect_ASPApp.swift
//  pawfect_ASP
//
//  Created by Prithvi’s Macbook on 10/8/24.
//

import SwiftUI
import SwiftData

@main
struct pawfect_ASPApp: App {
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
