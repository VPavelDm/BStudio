//
//  DayPickerView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 23.09.21.
//

import SwiftUI

struct DayPickerView: View {
    @State private var selectionDate = Date()
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
        CalendarView(selection: $selectionDate)
    }
    private var timePicker: some View {
        TimePickerView(selectionDate: $selectionDate)
    }
    private var next: some View {
        NavigationLink(destination: Text("Hello"), isActive: $shouldNavigateToNextScreen) {
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
        }
    }
}
