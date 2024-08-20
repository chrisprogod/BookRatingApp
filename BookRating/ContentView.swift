//
//  ContentView.swift
//  BookRating
//
//  Created by Christian Teguim on 2024-08-19.
//

import SwiftUI

struct BookListView: View {
    @State private var createBook = false
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
            .navigationTitle("Books")
            .toolbar {
                
                Button {
                    createBook = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                    
                }
            }.sheet(isPresented: $createBook, content: {
                AddNewBook()
                    .presentationDetents([.medium])
            })
        }
    }
}

#Preview {
    BookListView()
}
