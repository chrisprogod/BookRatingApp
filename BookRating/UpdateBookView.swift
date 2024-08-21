//
//  UpdateBookView.swift
//  BookRating
//
//  Created by Christian Teguim on 2024-08-21.
//
import SwiftUI

struct UpdateBookView: View {
    @Environment(\.dismiss) private var dismiss
    let book: Book
    @State private var status = Status.onShelf
    @State private var title = ""
    @State private var author = ""
    @State private var summary = ""
    @State private var dateAdded = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateFinished = Date.distantPast
    @State private var firstView = true
    
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
                if status == .CurrentlyReading || status == .finished {
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
            .onChange(of: status) { oldValue, newValue in
                if !firstView {
                    if newValue == .onShelf {
                        dateStarted = Date.distantPast
                        dateFinished = Date.distantPast
                    } else if newValue == .CurrentlyReading && oldValue == .finished {
                        // from completed to inProgress
                        dateFinished = Date.distantPast
                    } else if newValue == .inProgress && oldValue == .onShelf {
                        // Book has been started
                        dateStarted = Date.now
                    } else if newValue == .completed && oldValue == .onShelf {
                        // Forgot to start book
                        dateFinished = Date.now
                        dateStarted = dateAdded
                    } else {
                        // completed
                        dateFinished = Date.now
                    }
                    firstView = false
                }
            }
            Divider()
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
            Text("Summary").foregroundStyle(.secondary)
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
    }
}

//#Preview {
//    NavigationStack {
//        EditBookView()
//    }
//}
