//
//  ContentView.swift
//  Bookworm
//
//  Created by Bruce Wang on 2024/1/4.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var students: [Student]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(students) { student in
                    Text("\(student.firstName) \(student.lastName)")
                }
            }
            .navigationTitle("Students")
            .toolbar {
                Button(action: {
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                            let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                            let chosenFirstName = firstNames.randomElement()!
                            let chosenLastName = lastNames.randomElement()!
                    modelContext.insert(Student(id: UUID(), firstName: chosenFirstName, lastName: chosenLastName))
                }, label: {
                    Image(systemName: "plus")
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
