//
//  DetailView.swift
//  Bookworm
//
//  Created by Bruce Wang on 2024/1/6.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let book: Book
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                if AddBookView.genres.contains(book.genre) {
                    Image(book.genre)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(systemName: "smile")
                }
                    

                Text(book.genre.uppercased())
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.7))
                    .clipShape(.capsule)
                    .offset(x: -10, y: -10)
            }
            
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            
            Text(book.date, style: .date)
            
            Text(book.review)
                .padding()
            
            RatingView(rating: .constant(4))
                .font(.largeTitle)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete a book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button("Delete this book", systemImage: "alert") {
                showingDeleteAlert.toggle()
            }
        }
    }
    
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test book", author: "Test Author", genre: "Fantasy", review: "This is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test reviewThis is test review", rating: 4, date: Date.now)
        return DetailView(book: example)
            .modelContainer(container)
        
    } catch {
        return Text(error.localizedDescription)
    }
    
}
