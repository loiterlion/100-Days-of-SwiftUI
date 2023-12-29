//
//  ContentView.swift
//  HabitTracker
//
//  Created by Bruce Wang on 2023/12/29.
//

import SwiftUI

@Observable
class Habits {
    var items: [Habit] = [] {
        didSet {
            save()
        }
    }
    
    init() {
        load()
    }
    
    func load() {
        if let data = UserDefaults.standard.data(forKey: "data") {
            if let decoded = try? JSONDecoder().decode([Habit].self, from: data) {
                items = decoded
                return
            }
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(items)
            UserDefaults.standard.setValue(data, forKey: "data")
        } catch {
            print(error.localizedDescription)
        }
    }
}



struct ContentView: View {
    @State private var habits: Habits = Habits()
    @State private var showingSheet = false
    var body: some View {
        NavigationStack{
            VStack {
                List {
                    ForEach(habits.items) { item in
                        NavigationLink(destination: HabitDetailVew(item: item, habits: habits)) {
                            VStack(alignment: .leading){
                                Text("\(item.title)")
                                    .font(.headline)
                                Text("\(item.description)")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        showingSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingSheet, content: {
                AddHabitView(habits: habits)
            })
        }
    }
}

#Preview {
    ContentView()
}
