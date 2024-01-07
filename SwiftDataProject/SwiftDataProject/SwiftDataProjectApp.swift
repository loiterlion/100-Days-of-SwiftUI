//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Bruce Wang on 2024/1/7.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
