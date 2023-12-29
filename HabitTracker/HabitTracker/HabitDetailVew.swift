//
//  HabitDetailVew.swift
//  HabitTracker
//
//  Created by Bruce Wang on 2023/12/29.
//

import SwiftUI

struct HabitDetailVew: View {
    @Environment(\.dismiss) var dismiss
    
    @State var item: Habit
    @State var habits: Habits
    
    var body: some View {
        NavigationStack {
            Form {
                Text(item.title)
                Text(item.description)
                Text("Finish count: \(item.finishCount)")
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Add finish count") {
                        if let index = habits.items.firstIndex(of: item) {
                            item.finishCount += 1
                            habits.items[index] = item
                        }
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    HabitDetailVew(item: Habit(title: "a", description: "aaa", finishCount: 0), habits: Habits())
}
