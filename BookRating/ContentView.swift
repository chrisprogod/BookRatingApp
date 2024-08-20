//
//  ContentView.swift
//  BookRating
//
//  Created by Christian Teguim on 2024-08-19.
//

import SwiftUI

struct BookListView: View {
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
                    
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                    
                }
            }
        }
    }
}

#Preview {
    BookListView()
}
