//
//  CalendarView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 21.09.21.
//

import SwiftUI

struct CalendarView: View {
    
    // MARK: - Properties
    private let columns: [GridItem] = (1...7).map { _ in GridItem(.flexible()) }
    @ObservedObject private var calendar: CalendarViewModel
    @Binding var selectionDate: Date
    
    // MARK: - Inits
    init(selection: Binding<Date>) {
        _selectionDate = selection
        calendar = CalendarViewModel(selectionDate: selection.wrappedValue)
    }

    // MARK: - Views
    var body: some View {
        ScrollView([]) {
            VStack {
                header
                days
            }
        }
    }
    private var header: some View {
        HStack {
            monthAndYear
            Spacer()
            monthsControl
        }
        .padding(.horizontal, 8)
    }
    
    // MARK: Month and year chooser
    private var monthAndYear: some View {
        Button {} label: {
            HStack {
                Text(calendar.formatMonthAndYear(for: selectionDate))
                    .foregroundColor(.primary)
                    .font(.system(size: 17, weight: .semibold))
                Image(systemName: "chevron.forward")
            }
        }
    }
    private var monthsControl: some View {
        HStack(spacing: 32) {
            Button {
                selectionDate = calendar.sameDateInPreviousMonth(for: selectionDate)
            } label: {
                Image(systemName: "chevron.backward")
            }
            Button {
                selectionDate = calendar.sameDateInNextMonth(for: selectionDate)
            } label: {
                Image(systemName: "chevron.forward")
            }
        }
    }
    
    // MARK: Day's numbers
    private var days: some View {
        LazyVGrid(columns: columns) {
            ForEach(calendar.daysLetters, id: \.self) { letters in
                weekdayView(letters)
            }
            ForEach(calendar.days.indices, id: \.self) { index in
                dayView(calendar.days[index])
            }
        }
    }
    private func weekdayView(_ text: String) -> some View {
        Text(text.uppercased())
            .font(.system(size: 13, weight: .semibold))
            .foregroundColor(.tertiaryLabel)
    }
    private func dayView(_ day: Day) -> some View {
        ZStack {
            Circle()
                .foregroundColor(calendar.circleColor(for: day.date, selection: selectionDate))
            dayTextView(day)
                .onTapGesture {
                    selectionDate = day.date
                }
                .disabled(!calendar.isDateEnabled(day.date, selection: selectionDate))
        }
        .aspectRatio(1.0, contentMode: .fill)
    }
    private func dayTextView(_ day: Day) -> some View {
        Text("\(day.number)")
            .foregroundColor(calendar.textColor(for: day.date, selection: selectionDate))
            .font(calendar.isSelectedDate(day.date, selection: selectionDate) ? .system(size: 22, weight: .semibold) : .system(size: 20, weight: .regular))
    }
}

struct CalendarView_Previews: PreviewProvider {
    struct ContentView: View {
        @State var selection = Date()
        var body: some View {
            CalendarView(selection: $selection)
        }
    }
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .padding()
    }
}

