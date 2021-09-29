//
//  SongTO.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 29.09.21.
//

import Foundation

struct SongTO: Codable {
    var id: Int
    var imageURL: String
    var userFriendlyName: String
    var songName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "image_url"
        case userFriendlyName = "user_friendly_name"
        case songName = "song_name"
    }
}
