//
//  TimePickButtonStyle.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 24.09.21.
//

import SwiftUI

struct TimePickButtonStyle: ButtonStyle {
    var time: String
    var startTime: String?
    var endTime: String?
    private var isSelected: Bool {
        startTime == time || endTime == time
    }
    private var isBetweenStartAndEndTimes: Bool {
        guard let startTime = startTime else { return false }
        guard let endTime = endTime else { return false }
        let time = convertTimeToDouble(time)
        let start = convertTimeToDouble(startTime)
        let end = convertTimeToDouble(endTime)
        return min(start, end) < time && time < max(start, end)
    }
    private func convertTimeToDouble(_ time: String) -> Double {
        let components = time.split(separator: ":")
        let hours = Double(components.first!)!
        let minutes = components.last == "00" ? 0 : 0.5
        return hours + minutes
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .foregroundColor(.white)
            .background(
                Group {
                    if isSelected {
                        Color.selectedTimeCardBackground
                    } else if configuration.isPressed {
                        Color.highlightTimeCardBackground
                    } else if isBetweenStartAndEndTimes {
                        Color.highlightTimeCardBackground
                    } else {
                        Color.timeCardBackground
                    }
                }
            )
    }
    
}
