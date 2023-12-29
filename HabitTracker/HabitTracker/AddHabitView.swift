//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by Bruce Wang on 2023/12/29.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.dismiss) var dismiss;
    
    @State private var title: String = ""
    @State private var description: String = ""
    var habits: Habits
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add a new habit")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        save()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        cancel()
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .toolbarTitleDisplayMode(.inline)
        }
    }
    
    func save() {
        let habit = Habit(title: title, description: description, finishCount: 0)
        habits.items.append(habit)
        dismiss()
    }
    
    func cancel() {
        dismiss()
    }
}

#Preview {
    AddHabitView(habits: Habits())
}
