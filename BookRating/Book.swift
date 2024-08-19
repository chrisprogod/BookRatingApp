//
//  Book.swift
//  BookRating
//
//  Created by Christian Teguim on 2024-08-19.
//

import Foundation
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
    
    init(
        author: String,
        title: String,
        dateAdded: Date = Date.now,
        dateStarted: Date = Date.distantPast,
        dateFinished: Date = Date.distantPast,
        summary: String = "",
        status: Status = .onShelf
    ) {
        self.author = author
        self.title = title
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateFinished = dateFinished
        self.summary = summary
        self.status = status
    }
}

enum Status: Int, Codable, CaseIterable, Identifiable {
    case onShelf, CurrentlyReading, finished
    var id: Self {
        self
    }
    var descript: String {
        switch self {
        case .onShelf:
            "On Shelf"
        case .CurrentlyReading:
            "Currently Reading"
        case .finished:
            "Finished"
        }
    }
}
