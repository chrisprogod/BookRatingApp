import SwiftUI
import SwiftData

struct BookListView: View {
    @Query(sort: \Book.title) private var books: [Book]
    @State private var createBook = false
    
    var body: some View {
        NavigationStack {
           Group {
                if books.isEmpty {
                    ContentUnavailableView("Enter your first book.", systemImage: "book")
                } else {
                    List {
                        ForEach(books) { book in
                            NavigationLink {
                                // Navigation destination content here
                            } label: {
                                HStack(spacing: 10) {
                                    book.icon
                                    VStack(alignment: .leading) {
                                        Text(book.title).font(.title2)
                                        Text(book.author).foregroundStyle(.secondary)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Books")
            .toolbar {
                Button {
                    createBook = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                }
            }
            .sheet(isPresented: $createBook) {
                AddNewBook()
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    BookListView()
        .modelContainer(for: Book.self, inMemory: true)
}
