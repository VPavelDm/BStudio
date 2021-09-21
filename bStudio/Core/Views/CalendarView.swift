//
//  CalendarView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 21.09.21.
//

import SwiftUI

struct CalendarView: View {
    var availableTime: [String] = (0...12).map { String($0) }
    
    var body: some View {
        HStack(alignment: .center, spacing: .contentSpacing) {
            labelsColumn
            timeColumns
            labelsColumn
        }
    }
    private var labelsColumn: some View {
        VStack(alignment: .trailing, spacing: .timeLabelsSpacing) {
            ForEach(availableTime, id: \.self) { time in
                labelView(time)
            }
        }
    }
    private func labelView(_ time: String) -> some View {
        HStack(alignment: .top, spacing: 0) {
            Text(time)
                .font(.bottomTime)
                .padding(.top, .topTimePadding)
            Text("00")
                .font(.upperTime)
        }
        .frame(height: .timeLabelHeight)
    }
    private var timeColumns: some View {
        GeometryReader { geoemetry in
            let count = Int(geoemetry.size.width / .timeColumnWidth)
            HStack(spacing: .columnsSpacing) {
                ForEach(0..<count, id: \.self) { index in
                    timeRanges
                }
            }
        }
        .frame(height: .columnHeight(rectangesCount: availableTime.count - 1))
    }
    private var timeRanges: some View {
        VStack(spacing: 0) {
            ForEach(0..<availableTime.count-1, id: \.self) { index in
                timeRange(isLast: index == availableTime.count - 2)
            }
        }
    }
    private func timeRange(isLast: Bool) -> some View {
        VStack(spacing: 0) {
            Rectangle().frame(height: 1)
            Spacer()
            if isLast {
                Rectangle().frame(height: 1)
            }
        }
        .frame(height: .timeRangeRectangleHeight)
    }
}

fileprivate extension CGFloat {
    static var contentSpacing: CGFloat = 10
    static var timeLabelsSpacing: CGFloat = 4
    static var topTimePadding: CGFloat = 2
    static var timeLabelHeight: CGFloat = 36
    static var timeColumnWidth: CGFloat = 80
    static var columnsSpacing: CGFloat = 12
    static var timeRangeRectangleHeight: CGFloat = 40
    static func columnHeight(rectangesCount: Int) -> CGFloat {
        CGFloat(rectangesCount) * .timeRangeRectangleHeight
    }
}
fileprivate extension Font {
    static var bottomTime: Font = .system(size: 24, weight: .regular)
    static var upperTime: Font = .system(size: 12, weight: .regular)
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
