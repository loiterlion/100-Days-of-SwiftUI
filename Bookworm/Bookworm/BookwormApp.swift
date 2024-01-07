//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Bruce Wang on 2024/1/4.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
