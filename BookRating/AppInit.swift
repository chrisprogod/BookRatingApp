//
//  BookRatingApp.swift
//  BookRating
//
//  Created by Christian Teguim on 2024-08-19.
//

import SwiftUI
import SwiftData

@main
struct BookRating: App {
    var body: some Scene {
        WindowGroup {
            BookListView()
        }
        .modelContainer(for: Book.self)
    }
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
