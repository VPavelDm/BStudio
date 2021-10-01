//
//  DateMapper.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 30.09.21.
//

import Foundation

struct DateMapper {
    var time: String
    var date: Date
    
    var serverTime: Double {
        let components = time.split(separator: ":")
        let hour = Int(components[0])!
        let minutes = Int(components[1])!
        return Calendar(identifier: .gregorian).date(bySettingHour: hour, minute: minutes, second: 0, of: date)!.timeIntervalSince1970
    }
}
