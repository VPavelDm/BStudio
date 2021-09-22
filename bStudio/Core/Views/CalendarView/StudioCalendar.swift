//
//  StudioCalendar.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 21.09.21.
//

import SwiftUI

class StudioCalendar: ObservableObject {
    private var availableTimeForDates: [String: [String]] = [:]
    var availableTime: [String] = (0...12).map { String($0) }
    var rangesCount: Int { availableTime.count - 1 }
    
    func isTimeOccupied(_ time: String, in column: Int) -> Bool {
        false
    }
    func formattedDate(offsetFromToday: Int) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd"
        let date = Calendar.current.date(byAdding: .day, value: offsetFromToday, to: Date())!
        return formatter.string(from: date)
    }
}
