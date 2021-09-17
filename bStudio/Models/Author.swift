//
//  Author.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 17.09.21.
//

import Foundation

struct Author: Identifiable {
    var id: UUID = UUID()
    var name: String
    var imageURL: URL
    
    init(name: String, imageURL: String) {
        self.name = name
        self.imageURL = URL(string: imageURL)!
    }
}
