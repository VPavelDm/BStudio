//
//  Author.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 17.09.21.
//

import Foundation

struct Author: Identifiable, Equatable {
    var id: UUID = UUID()
    var name: String
    var imageURL: URL
    var arrangements: [Arrangement]
    var songs: [Song]
    
    init(name: String, imageURL: String, arrangements: [Arrangement], songs: [Song]) {
        self.name = name
        self.imageURL = URL(string: imageURL)!
        self.arrangements = arrangements
        self.songs = songs
    }
    
    static func ==(lhs: Author, rhs: Author) -> Bool {
        lhs.id == rhs.id
    }
}
