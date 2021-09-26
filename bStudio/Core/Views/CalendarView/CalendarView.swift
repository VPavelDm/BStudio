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
    @StateObject private var calendar: CalendarViewModel = CalendarViewModel()
    @State private var isBackTransitionAnimation = false
    @Binding var selectionDate: Date
    @State private var selectionPage = 0
    
    // MARK: - Inits
    init(selection: Binding<Date>) {
        _selectionDate = selection
    }

    // MARK: - Views
    var body: some View {
        VStack {
            header.animation(nil)
            days
                .id(selectionPage)
                .transition(
                    .asymmetric(
                        insertion:.move(edge: isBackTransitionAnimation ? .leading : .trailing),
                        removal: .move(edge: isBackTransitionAnimation ? .trailing : .leading)
                    ))
        }
        .frame(maxHeight: 354)
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
        Text(calendar.formatMonthAndYear(for: selectionPage))
            .foregroundColor(.primary)
            .font(.system(size: 17, weight: .semibold))
    }
    private var monthsControl: some View {
        HStack(spacing: 32) {
            Button {
                withAnimation {
                    isBackTransitionAnimation = true
                    selectionPage -= 1
                    calendar.updateDays(for: selectionPage)
                }
            } label: {
                Image(systemName: "chevron.backward")
            }
            .disabled(selectionPage == 0)
            Button {
                withAnimation {
                    isBackTransitionAnimation = false
                    selectionPage += 1
                    calendar.updateDays(for: selectionPage)
                }
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
                .foregroundColor(calendar.isTheSameDate(day.date, selection: selectionDate) ? .xanadu : .clear)
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
            .font(calendar.isTheSameDate(day.date, selection: selectionDate) ? .system(size: 22, weight: .semibold) : .system(size: 20, weight: .regular))
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
            .padding()
    }
}

