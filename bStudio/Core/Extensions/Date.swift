//
//  Date.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 21.09.21.
//

import Foundation

extension Date {
    static var yesterday: Date { Date().dayBefore }
    static var tomorrow:  Date { Date().dayAfter }
    static var today: Date { Date().noon }
    var dayBefore: Date {
        Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
}
