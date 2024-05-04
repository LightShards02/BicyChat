//
//  BicyChatApp.swift
//  BicyChat
//
//  Created by Kevin on 5/3/24.
//

import SwiftUI
import SwiftData

@main
struct BicyChatApp: App {
    //    var sharedModelContainer: ModelContainer = {
    //        let schema = Schema([
    //            Account.self,
    //        ])
    //        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
    //
    //        do {
    //            return try ModelContainer(for: schema, configurations: [modelConfiguration])
    //        } catch {
    //            fatalError("Could not create ModelContainer: \(error)")
    //        }
    //    }()
    
    var body: some Scene {
        WindowGroup {
            SignupView()
        }
        .modelContainer(for: Account.self)
    }
    
}
