//
//  StudioTO.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 29.09.21.
//

import Foundation

struct StudioTO: Codable {
    var authors: [AuthorTO]
    var workTimes: [String]
    var reservations: [ReservationTO]
    
    enum CodingKeys: String, CodingKey {
        case authors
        case workTimes = "work_times"
        case reservations
    }
}
