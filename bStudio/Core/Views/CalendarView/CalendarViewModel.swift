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
    var days: [Day] = CalendarViewModel.generateDaysInMonth(for: Date())
    // 7 строк: [Пн, Вт, Ср, ..., Вс]
    var daysLetters: [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return days
            .prefix(upTo: 7)
            .map { day in dateFormatter.string(from: day.date) }
    }
    
    // MARK: - Intents
    func updateDays(for page: Int) {
        let dateInMonth = calendar.date(byAdding: .month, value: page, to: Date()) ?? Date()
        days = CalendarViewModel.generateDaysInMonth(for: dateInMonth)
    }
    func circleColor(_ date: Date, selectionDate: Date, selectionPage: Int) -> Color {
        let anyDateForMonthWithinPage = calendar.date(byAdding: .month, value: selectionPage, to: Date()) ?? Date()
        guard calendar.isDate(selectionDate, inSameMonthAs: anyDateForMonthWithinPage) else { return .clear }
        return isTheSameDate(date, selection: selectionDate) ? .xanadu : .clear
    }
    func isTheSameDate(_ date: Date, selection: Date) -> Bool {
        calendar.isDate(date, inSameDayAs: selection)
    }
    func isDateEnabled(_ date: Date, selectionPage: Int) -> Bool {
        let anyDateForMonthWithinPage = calendar.date(byAdding: .month, value: selectionPage, to: Date()) ?? Date()
        guard calendar.isDate(date, inSameMonthAs: anyDateForMonthWithinPage) else { return false }
        return !calendar.isDateInPastAndNotToday(date)
    }
    func textColor(for date: Date, selection: Date, selectionPage: Int) -> Color {
        let anyDateForMonthWithinPage = calendar.date(byAdding: .month, value: selectionPage, to: Date()) ?? Date()
        guard calendar.isDate(date, inSameMonthAs: anyDateForMonthWithinPage) else { return .clear }
        guard !isTheSameDate(date, selection: selection) else { return .white }
        guard !isTheSameDate(date, selection: Date()) else { return .red }
        return calendar.isDateInPastAndNotToday(date) ? .secondary : .primary
    }
    func textFont(for date: Date, selectionDate: Date) -> Font {
        if isTheSameDate(date, selection: selectionDate) {
            return .system(size: 22, weight: .semibold)
        } else {
            return .system(size: 20, weight: .regular)
        }
    }
    func formatMonthAndYear(for page: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale.autoupdatingCurrent
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM y")
        let date = calendar.date(byAdding: .month, value: page, to: Date()) ?? Date()
        return dateFormatter.string(from: date)
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
