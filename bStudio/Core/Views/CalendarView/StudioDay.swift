//
//  StudioDay.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 22.09.21.
//

import Foundation

struct StudioDay: Identifiable, Hashable, Equatable {
    var id: Date { date }
    var date: Date
    var occupiedTime: [Range<Date>]
    
    // MARK: - Hashable, Equatable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func ==(lhs: StudioDay, rhs: StudioDay) -> Bool {
        lhs.id == rhs.id
    }
}
