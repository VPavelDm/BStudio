//
//  Song.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 17.09.21.
//

import Foundation

struct Song: Identifiable {
    var id = UUID()
    var imageURL: URL
    var userFriendlyName: String
    var songName: String
    
    init(imageURL: String, userFriendlyName: String, songName: String) {
        self.imageURL = URL(string: imageURL)!
        self.userFriendlyName = userFriendlyName
        self.songName = songName
    }
    
    var path: String {
        Bundle.main.path(forResource: songName, ofType: "mp3")!
    }
}
