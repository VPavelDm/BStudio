//
//  StudioCalendar.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 21.09.21.
//

import SwiftUI

class StudioCalendar: ObservableObject {
    
    // MARK: - Outputs
    private(set) var pages: [[StudioDay]] = createPages()
    
    // MARK: - Intents
    func formattedWeekday(for day: StudioDay) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEEE"
        return formatter.string(from: day.date)
    }
    func formattedDayNumber(for day: StudioDay) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: day.date)
    }
    func formattedFullDay(for day: StudioDay) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMMM, yyyy"
        return formatter.string(from: day.date)
    }
    func isDayBeforeToday(_ day: StudioDay) -> Bool {
        day.date < Date.today
    }
    func isToday(_ day: StudioDay) -> Bool {
        Calendar.current.isDateInToday(day.date)
    }
    
    // MARK: - Utils
    private static func createPages() -> [[StudioDay]] {
        let days = (-2..<100)
            .map { index in
                Calendar.current.date(byAdding: .day, value: index, to: Date().noon)!
            }
            .map { date in StudioDay(date: date, occupiedTime: []) }
        
        var pages: [[StudioDay]] = []
        var pageNumber = 0
        while true {
            guard pageNumber * 7 + 7 < days.count else { break }
            let page = Array(days[pageNumber*7..<pageNumber*7+7])
            pages.append(page)
            pageNumber += 1
        }
        
        return pages
    }
}
