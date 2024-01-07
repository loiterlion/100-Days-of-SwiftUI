//
//  AddBookView.swift
//  Bookworm
//
//  Created by Bruce Wang on 2024/1/6.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Kids"
    @State private var review = ""
    @State private var showingAlert = false
    
    static let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        Form {
            Section {
                TextField("Name of book", text: $title)
                TextField("Author's name", text: $author)
                
                Picker("Choose a genre", selection: $genre) {
                    ForEach(Self.genres, id: \.self) {
                        Text($0)
                    }
                }
            }
            
            Section("Write a review") {
                TextEditor(text: $review)
                
                RatingView(rating: $rating)
            }
            
            Section {
                Button("Save") {
                    let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, date: Date.now)
                    guard newBook.isValid else {
                        showingAlert.toggle()
                        return
                    }
                        
                    modelContext.insert(newBook)
                    dismiss()
                }
            }
//            .alert(isPresented: $showingAlert,
            .alert("Alert", isPresented: $showingAlert, actions: {
                Button("OK"){}
            }, message: {
                Text("Content empty error")
            })
            .navigationTitle("Add Book")
        }
    }
}

#Preview {
    AddBookView()
}
