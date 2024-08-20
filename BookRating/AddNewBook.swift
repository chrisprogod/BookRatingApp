//
//  AddNewBook.swift
//  BookRating
//
//  Created by Christian Teguim on 2024-08-20.
//

import SwiftUI

struct AddNewBook: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var author = ""
    var body: some View {
        NavigationStack {
            Form {
                TextField("Book Title", text: $title)
                TextField("Author Name", text: $author)
                Button("Create") {
                    let newBook = Book(author: author, title: title)
                    context.insert(newBook)
                    dismiss()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(.borderedProminent)
                .padding(.vertical)
                .disabled(title.isEmpty || author.isEmpty)
                .navigationTitle("New Book")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AddNewBook()
}
