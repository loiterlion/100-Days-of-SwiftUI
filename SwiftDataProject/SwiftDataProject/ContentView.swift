//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Bruce Wang on 2024/1/7.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \User.name) var users: [User]
    @State private var path = [User]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(users, id:\.self) { user in
                    NavigationLink(value: user) {
                        Text(user.name)
                    }
                }
            }
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { item in
                EditUserView(user: item)
            }
            .toolbar {
                Button("Add User", systemImage: "plus") {
                    let user = User(name: "", city: "", joinDate: .now)
                    modelContext.insert(user)
                    path = [user]
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
