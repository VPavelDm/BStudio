//
//  CalendarViewModel.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 22.09.21.
//

import SwiftUI

class CalendarViewModel: ObservableObject {
    private var calendar: Calendar { CalendarViewModel.calendar }
    
    // MARK: - Properties
    var days: [Day]
    // 7 строк: [Пн, Вт, Ср, ..., Вс]
    var daysLetters: [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return days
            .prefix(upTo: 7)
            .map { day in dateFormatter.string(from: day.date) }
    }

    // MARK: - Inits
    init(selectionDate: Date) {
        days = CalendarViewModel.generateDaysInMonth(for: selectionDate)
    }
    
    // MARK: - Intents
    func isSelectedDate(_ date: Date, selection: Date) -> Bool {
        calendar.isDate(date, inSameDayAs: selection)
    }
    func isDateEnabled(_ date: Date, selection: Date) -> Bool {
        guard calendar.isDate(date, inSameMonthAs: selection) else { return false }
        return !calendar.isDateInPastAndNotToday(date)
    }
    func textColor(for date: Date, selection: Date) -> Color {
        guard !isSelectedDate(date, selection: selection) else { return .white }
        guard calendar.isDate(date, inSameMonthAs: selection) else { return .white }
        return calendar.isDateInPastAndNotToday(date) ? .secondary : .primary
    }
    func formatMonthAndYear(for selection: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM y")
        return dateFormatter.string(from: selection)
    }
}

// MARK: - Generation
fileprivate extension CalendarViewModel {
    private static let calendar = Calendar(identifier: .gregorian)
    
    private static func monthMetadata(for baseDay: Date) throws -> MonthMetadata {
        guard let numberOfDaysInMonth = calendar.range(of: .day, in: .month, for: baseDay)?.count else {
            throw CalendarDataError.metadataGeneration
        }
        
        guard let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: baseDay)) else {
            throw CalendarDataError.metadataGeneration
        }
        
        let firstDayWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        
        return MonthMetadata(numberOfDaysInMonth: numberOfDaysInMonth,
                             firstDay: firstDayOfMonth,
                             firstDayWeekday: firstDayWeekday)
    }
    private static func generateDaysInMonth(for baseDate: Date) -> [Day] {
        guard let metadata = try? monthMetadata(for: baseDate) else { return [] }
        
        let numberOfDaysInMonth = metadata.numberOfDaysInMonth
        let offsetInInitialRow = metadata.firstDayWeekday
        let firstDayOfMonth = metadata.firstDay
        
        var days: [Day] = (1..<(numberOfDaysInMonth + offsetInInitialRow))
            .map { day in
                let isWithinDisplayedMonth = day >= offsetInInitialRow
                let dayOffset = isWithinDisplayedMonth ? day - offsetInInitialRow : -(offsetInInitialRow - day)
                
                return generateDay(offsetBy: dayOffset,
                                   for: firstDayOfMonth,
                                   isWithinDisplayedMonth: isWithinDisplayedMonth)
            }
        days.append(contentsOf: generateStartOfNextMonth(using: firstDayOfMonth))
        
        return days
    }
    private static func generateStartOfNextMonth(using firstDayOfDisplayedMonth: Date) -> [Day] {
        // Последний день отображаемого месяца (+месяц к первому дню отбрж месяца и -1 день)
        guard let lastDayInMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: firstDayOfDisplayedMonth) else {
            return []
        }
        
        let additionalDays = 7 - calendar.component(.weekday, from: lastDayInMonth)
        guard additionalDays > 0 else { return [] }
        
        return (1...additionalDays)
            .map { dayOffset in
                generateDay(offsetBy: dayOffset, for: lastDayInMonth, isWithinDisplayedMonth: false)
            }
    }
    private static func generateDay(offsetBy dayOffset: Int, for baseDate: Date, isWithinDisplayedMonth: Bool) -> Day {
        let date = calendar.date(byAdding: .day, value: dayOffset, to: baseDate) ?? baseDate
        return Day(date: date)
    }
    
    private enum CalendarDataError: Error {
      case metadataGeneration
    }
}
