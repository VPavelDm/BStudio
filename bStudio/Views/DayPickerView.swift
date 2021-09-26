//
//  DayPickerView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 23.09.21.
//

import SwiftUI

struct DayPickerView: View {
    @EnvironmentObject private var studio: Studio
    @EnvironmentObject var orderDetails: OrderDetails
    @State private var shouldNavigateToNextScreen = false
    
    var body: some View {
        VStack(alignment: .leading) {
            title.padding([.horizontal, .top], 16)
            ScrollView {
                content
                    .padding([.horizontal, .bottom], 16)
            }
        }
        .background(Color.background.edgesIgnoringSafeArea([.bottom, .horizontal]))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("VOSTOK'7")
        .navigationBarColor(backgroundColor: .woodsmoke, titleColor: .white)
    }
    private var content: some View {
        VStack(spacing: 24) {
            calendar
            timePicker
            next
        }
        .padding(.horizontal, 8)
    }
    private var title: some View {
        Text("Выберите дату")
            .font(.system(size: 34, weight: .regular))
            .foregroundColor(.white)
    }
    private var calendar: some View {
        CalendarView(selection: $orderDetails.selectionDate,
                     unavailableDateRanges: studio.reservations.map { $0.timeInterval })
    }
    private var timePicker: some View {
        TimePickerView(startTime: $orderDetails.startTime,
                       endTime: $orderDetails.endTime,
                       times: studio.workTimes)
    }
    private var next: some View {
        NavigationLink(destination: AuthenticationView(), isActive: $shouldNavigateToNextScreen) {
            RoundedButton(text: "Дальше") {
                shouldNavigateToNextScreen = true
            }
        }
    }
}

struct DayPickerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DayPickerView()
                .preferredColorScheme(.dark)
                .environmentObject(Studio())
                .environmentObject(OrderDetails())
        }
    }
}
