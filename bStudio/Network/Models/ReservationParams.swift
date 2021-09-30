//
//  MakeReservationParams.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 30.09.21.
//

import Foundation

struct MakeReservationParams {
    var phoneNumber: String
    var clientName: String
    var startTime: Double
    var endTime: Double
    var authorID: Int
    
    init(
        phoneNumber: String,
        clientName: String,
        startTime: String,
        endTime: String,
        date: Date,
        authorID: Int
    ) {
        self.phoneNumber = phoneNumber
        self.clientName = clientName
        self.startTime = DateMapper(time: startTime, date: date).serverTime
        self.endTime = DateMapper(time: endTime, date: date).serverTime
        self.authorID = authorID
    }
}

private struct DateMapper {
    var time: String
    var date: Date
    
    var serverTime: Double {
        let components = time.split(separator: ":")
        let hour = Int(components[0])!
        let minutes = Int(components[1])!
        return Calendar(identifier: .gregorian).date(bySettingHour: hour, minute: minutes, second: 0, of: date)!.timeIntervalSince1970
    }
}
