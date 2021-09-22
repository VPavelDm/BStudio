//
//  CalendarView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 21.09.21.
//

import SwiftUI

struct CalendarView: View {
    var calendar = StudioCalendar()
    @State private var currentPage = 0
    
    var body: some View {
        VStack(spacing: .contentSpacing) {
            days
            fullDayView(for: calendar.pages[0][0])
            Spacer()
        }
        .padding(.top)
    }
    private var days: some View {
        TabView {
            ForEach(calendar.pages.indices, id: \.self) { index in
                HStack {
                    ForEach(calendar.pages[index], id: \.self) { day in
                        dayView(for: day)
                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height: .daysHeight)
        .padding(.horizontal)
    }
    private func dayView(for day: StudioDay) -> some View {
        VStack {
            Text(calendar.formattedWeekday(for: day))
                .foregroundColor(.textColor)
            Text(calendar.formattedDayNumber(for: day))
                .foregroundColor(.textColor)
                .padding(8)
                .background(Circle().foregroundColor(calendar.isToday(day) ? .red : .clear))
        }
        .frame(maxWidth: .infinity)
    }
    private func fullDayView(for day: StudioDay) -> some View {
        Text(calendar.formattedFullDay(for: day))
            .foregroundColor(.textColor)
    }
}

fileprivate extension CGFloat {
    static var contentSpacing: CGFloat = 8
    static var daysHeight: CGFloat = 65
}
fileprivate extension Font {
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CalendarView()
                .background(Color.background.edgesIgnoringSafeArea([.bottom, .horizontal]))
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("VOSTOK'7")
                .navigationBarColor(backgroundColor: .woodsmoke, titleColor: .white)
        }
    }
}
