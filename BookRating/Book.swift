//
//  Book.swift
//  BookRating
//
//  Created by Christian Teguim on 2024-08-19.
//

import SwiftUI
import SwiftData

@Model
class Book {
    var author: String
    var title: String
    var dateAdded: Date
    var dateStarted: Date
    var dateFinished: Date
    var summary: String
    var status: Status
    var rating: Int?
    
    init(
        author: String,
        title: String,
        dateAdded: Date = Date.now,
        dateStarted: Date = Date.distantPast,
        dateFinished: Date = Date.distantPast,
        summary: String = "",
        status: Status = .onShelf,
        rating: Int? = nil
    ) {
        self.author = author
        self.title = title
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateFinished = dateFinished
        self.summary = summary
        self.status = status
        self.rating = rating
    }
    
    var icon: Image {
        switch status {
        case .onShelf:
            Image(systemName: "checkmark.diamond.fill")
        case .currentlyReading:
            Image(systemName: "book.fill")
        case .finished:
            Image(systemName: "books.vertical.fill")
        }
    }
}

enum Status: Int, Codable, CaseIterable, Identifiable {
    case onShelf, currentlyReading, finished
    var id: Self {
        self
    }
    var descript: String {
        switch self {
        case .onShelf:
            "On Shelf"
        case .currentlyReading:
            "Currently Reading"
        case .finished:
            "Finished"
        }
    }
}
