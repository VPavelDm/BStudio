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
        HStack {
            VStack {
                content
                Spacer()
            }
            .padding(16)
            Spacer()
        }
        .background(Color.background.edgesIgnoringSafeArea([.bottom, .horizontal]))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("VOSTOK'7")
        .navigationBarColor(backgroundColor: .woodsmoke, titleColor: .white)
    }
    private var content: some View {
        VStack(alignment: .leading, spacing: 28) {
            title
            VStack(spacing: 0) {
                calendar
                next
            }
            .padding(.horizontal, 8)
        }
    }
    private var title: some View {
        Text("Выберите дату")
            .font(.system(size: 34, weight: .regular))
            .foregroundColor(.white)
    }
    private var calendar: some View {
        CalendarView(selection: $selectionDate)
    }
    private var next: some View {
        NavigationLink(destination: TimePickerView(), isActive: $shouldNavigateToNextScreen) {
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
