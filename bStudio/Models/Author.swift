//
//  Author.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 17.09.21.
//

import Foundation

struct Author: Identifiable, Equatable {
    var id: Int
    var name: String
    var imageURL: URL
    var arrangements: [Arrangement]
    var masteringAndMixing: String?
    var songs: [Song]
    var services: [Service]
    
    init(id: Int,
         name: String,
         imageURL: String,
         arrangements: [Arrangement] = [],
         masteringAndMixing: String? = nil,
         songs: [Song],
         services: [Service]) {
        self.id = id
        self.name = name
        self.imageURL = URL(string: imageURL)!
        self.arrangements = arrangements
        self.songs = songs
        self.services = services
        self.masteringAndMixing = masteringAndMixing
    }
    
    static func ==(lhs: Author, rhs: Author) -> Bool {
        lhs.id == rhs.id
    }
}
