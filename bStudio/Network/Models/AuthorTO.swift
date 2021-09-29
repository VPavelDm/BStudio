//
//  AuthorTO.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 29.09.21.
//

import Foundation

struct AuthorTO: Codable {
    var id: Int
    var name: String
    var imageURL: String
    var masteringAndMixing: String?
    var services: [String]
    var arrangements: [ArrangementTO]
    var songs: [SongTO]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "image_url"
        case masteringAndMixing = "mastering_and_mixing"
        case services
        case arrangements
        case songs
    }

}
