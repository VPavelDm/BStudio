//
//  TimePickerView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 24.09.21.
//

import SwiftUI

struct TimePickerView: View {
    private let columns = (1...4).map { _ in GridItem(.flexible(), spacing: 8) }
    @Binding var startTime: String?
    @Binding var endTime: String?
    var times: [String]
    
    var body: some View {
        timeCalendar
    }
    
    private var timeCalendar: some View {
        VStack(alignment: .leading) {
            Text("Выберите промежуток времени")
                .foregroundColor(.textColor)
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(times, id: \.self) { time in
                    timeView(time)
                }
            }
        }
    }
    private func timeView(_ time: String) -> some View {
        Button {
            withAnimation {
                if startTime == time {
                    startTime = nil
                } else if endTime == time {
                    endTime = nil
                } else if startTime == nil {
                    startTime = time
                } else if endTime == nil {
                    endTime = time
                }
            }
        } label: {
            Text(time)
        }
        .buttonStyle(TimePickButtonStyle(time: time, startTime: startTime, endTime: endTime))
        .cornerRadius(16)
    }
}

struct TimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerView(startTime: .constant(nil), endTime: .constant(nil), times: ["9:00", "10:00"])
    }
}
