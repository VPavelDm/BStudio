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
        VStack {
            header
            days
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
                    .foregroundColor(.black)
                Image(systemName: "chevron.forward")
            }
        }
    }
    private var monthsControl: some View {
        HStack {
            Button {} label: {
                Image(systemName: "chevron.backward")
            }
            Button {} label: {
                Image(systemName: "chevron.forward")
            }
        }
    }
    
    // MARK: Day's numbers
    private var days: some View {
        LazyVGrid(columns: columns) {
            ForEach(calendar.daysLetters, id: \.self) { letters in
                Text(letters)
            }
            ForEach(calendar.days.indices, id: \.self) { index in
                dayView(calendar.days[index])
            }
        }
    }
    private func dayView(_ day: Day) -> some View {
        ZStack {
            Circle()
                .foregroundColor(calendar.isSelectedDate(day.date, selection: selectionDate) ? .red : .white)
            dayTextView(day)
                .onTapGesture {
                    selectionDate = day.date
                }
        }
        .aspectRatio(1.0, contentMode: .fill)
    }
    private func dayTextView(_ day: Day) -> some View {
        Text("\(day.number)")
            .foregroundColor(calendar.textColor(for: day.date, selection: selectionDate))
            .font(.system(size: 18, weight: .medium))
            .disabled(!calendar.isDateEnabled(day.date, selection: selectionDate))
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

