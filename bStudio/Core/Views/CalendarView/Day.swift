//
//  Day.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 22.09.21.
//

import Foundation

struct Day {
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter
    }()
    private let calendar = Calendar(identifier: .gregorian)
    var date: Date
    var number: String {
        dateFormatter.string(from: date)
    }
}
