//
//  ReservationTO.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 29.09.21.
//

import Foundation

struct ReservationTO: Codable {
    var id: Int
    var startTime: Double
    var endTime: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case startTime = "start_time"
        case endTime = "end_time"
    }
}
