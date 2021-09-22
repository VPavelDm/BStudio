//
//  CalendarView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 21.09.21.
//

import SwiftUI

struct CalendarView: View {
    @State private var calendar = StudioCalendar()
    
    var body: some View {
        VStack {
            header
            HStack(alignment: .center, spacing: .contentSpacing) {
                labelsColumn
                timeColumns
                labelsColumn
            }
        }
    }
    private var header: some View {
        HStack(alignment: .center) {
            back
            dates
            forward
        }
    }
    private var back: some View {
        Button {} label: {
            Image(systemName: "chevron.backward")
                .padding(12)
        }
    }
    private var forward: some View {
        Button {} label: {
            Image(systemName: "chevron.forward")
                .padding(12)
        }
    }
    private var dates: some View {
        GeometryReader { geometry in
            let count = Int(geometry.size.width / .timeColumnWidth)
            HStack(alignment: .center) {
                ForEach(0..<count, id: \.self) { index in
                    Text(calendar.formattedDate(offsetFromToday: index))
                        .font(.system(size: 24, weight: .regular))
                        .frame(width: geometry.size.width / CGFloat(count))
                }
            }
        }
        .frame(height: .dateLabelHeight)
    }
    private var labelsColumn: some View {
        VStack(alignment: .trailing, spacing: .timeLabelsSpacing) {
            ForEach(calendar.availableTime, id: \.self) { time in
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
        .frame(height: .columnHeight(rectangesCount: calendar.rangesCount))
    }
    private var timeRanges: some View {
        VStack(spacing: 0) {
            ForEach(0..<calendar.rangesCount, id: \.self) { index in
                timeRange(isLast: index == calendar.rangesCount - 1)
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
    static var dateLabelHeight: CGFloat = 30
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
