//
//  Calendar.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 23.09.21.
//

import Foundation

extension Calendar {
    func isDateInPastAndNotToday(_ date: Date) -> Bool {
        guard !isDateInToday(date) else { return false }
        return date < Date()
    }
    func isDate(_ date1: Date, inSameMonthAs date2: Date) -> Bool {
      isDate(date1, equalTo: date2, toGranularity: .month)
    }
}
