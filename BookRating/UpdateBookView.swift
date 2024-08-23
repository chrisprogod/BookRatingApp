//
//  UpdateBookView.swift
//  BookRating
//
//  Created by Christian Teguim on 2024-08-21.
//
import SwiftUI
import Translation
import Foundation

struct UpdateBookView: View {
    @Environment(\.dismiss) private var dismiss
    let book: Book
    @State var status = Status.onShelf
    @State var title = ""
    @State var author = ""
    @State var summary = ""
    @State var dateAdded = Date.distantPast
    @State var dateStarted = Date.distantPast
    @State var dateFinished = Date.distantPast
    @State var firstView = true
    @State var rating: Int?
    @State var showTranslation: Bool = false
    
    var body: some View {
        HStack {
            Text("Status")
            Picker("Status", selection: $status) {
                ForEach(Status.allCases) { status in
                    Text(status.descript).tag(status)
                }
            }
            .buttonStyle(.bordered)
        }
        VStack(alignment: .leading) {
            GroupBox {
                LabeledContent {
                    DatePicker("", selection: $dateAdded, displayedComponents: .date)
                } label: {
                    Text("Date Added")
                }
                if status == .currentlyReading || status == .finished {
                    LabeledContent {
                        DatePicker("", selection: $dateStarted, in: dateAdded..., displayedComponents: .date)
                    } label: {
                        Text("Date Started")
                    }
                }
                if status == .finished {
                    LabeledContent {
                        DatePicker("", selection: $dateFinished, in: dateStarted..., displayedComponents: .date)
                    } label: {
                        Text("Date Completed")
                    }
                }
            }
            .foregroundStyle(.secondary)
            Divider()
            LabeledContent {
                RatingsView(maxRating: 5, currentRating: $rating, width: 30)
            } label: {
                Text("Rating")
            }
            LabeledContent {
                TextField("", text: $title)
            } label: {
                Text("Title").foregroundStyle(.secondary)
            }
            LabeledContent {
                TextField("", text: $author)
            } label: {
                Text("Author").foregroundStyle(.secondary)
            }
            Divider()
            HStack {
                Text("Summary").foregroundStyle(.secondary)
                Spacer(minLength: 20)
                Button("Translate Text") {
                    showTranslation = true
                }
                .translationPresentation(isPresented: $showTranslation, text: summary)
            }
            TextEditor(text: $summary)
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(uiColor: .tertiarySystemFill), lineWidth: 2))
        }
        .padding()
        .textFieldStyle(.roundedBorder)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if changed {
                Button("Update") {
                    book.status = status
                    book.title = title
                    book.author = author
                    book.summary = summary
                    book.dateAdded = dateAdded
                    book.dateStarted = dateStarted
                    book.dateFinished = dateFinished
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .onAppear {
            status = book.status
            title = book.title
            author = book.author
            summary = book.summary
            dateAdded = book.dateAdded
            dateStarted = book.dateStarted
            dateFinished = book.dateFinished
            rating = book.rating
        }
    }
    
    var changed: Bool {
        status != book.status
        || title != book.title
        || author != book.author
        || summary != book.summary
        || dateAdded != book.dateAdded
        || dateStarted != book.dateStarted
        || dateFinished != book.dateFinished
        || rating != book.rating
    }
}

//#Preview {
//    NavigationStack {
//        UpdateBookView(book: Book)
//    }
//}
