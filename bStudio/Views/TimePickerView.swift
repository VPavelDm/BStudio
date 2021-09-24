//
//  TimePickerView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 24.09.21.
//

import SwiftUI

struct TimePickerView: View {
    @State private var shouldNavigateToNextScreen = false
    @State private var chosenTime: String?
    private let columns = (1...4).map { _ in GridItem(.flexible(), spacing: 8) }
    private var times = (8...23)
        .flatMap { number in ["\(number):00", "\(number):30"] }

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
            Group {
                timeCalendar
                next
            }
            .padding(.horizontal, 8)
        }
    }
    private var title: some View {
        Text("Выберите время")
            .font(.system(size: 34, weight: .regular))
            .foregroundColor(.textColor)
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
                if chosenTime == time {
                    chosenTime = nil
                } else {
                    chosenTime = time
                }
            }
        } label: {
            Text(time)
        }
        .buttonStyle(TimePickButtonStyle(isSelected: chosenTime == time))
        .cornerRadius(16)
    }
    private var next: some View {
        NavigationLink(destination: TimePickerView(), isActive: $shouldNavigateToNextScreen) {
            RoundedButton(text: "Дальше") {
                shouldNavigateToNextScreen = true
            }
        }
    }
}

struct TimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TimePickerView()
        }
    }
}
