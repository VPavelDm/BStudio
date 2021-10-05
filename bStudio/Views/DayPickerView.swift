//
//  DayPickerView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 23.09.21.
//

import SwiftUI

protocol DateDetails: ObservableObject {
    var selectionDate: Date { get set }
    var startTime: String? { get set }
    var endTime: String? { get set }
}

struct DayPickerView<ViewModel>: View where ViewModel: DateDetails, ViewModel: AuthenticationDetails {
    @EnvironmentObject private var studio: Studio
    @EnvironmentObject var dateDetails: ViewModel
    @State private var shouldNavigateToNextScreen = false
    @State private var notFilledFieldErrorMessage: IdentifiableString?
    
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
        .alert(item: $notFilledFieldErrorMessage) { message in
            Alert(title: Text("Вы не заполнили обязательные поля"),
                  message: Text(message.text),
                  dismissButton: .cancel(Text("Понятно")))
        }
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
        CalendarView(selection: $dateDetails.selectionDate,
                     unavailableDateRanges: studio.unavailableDateRanges)
    }
    private var timePicker: some View {
        TimePickerView(title: "Выберите время начала",
                       selectedTime: $dateDetails.startTime,
                       times: studio.workTimes)
    }
    private var next: some View {
        NavigationLink(destination: nextScreen, isActive: $shouldNavigateToNextScreen) {
            RoundedButton(text: "Дальше") {
                if dateDetails.startTime == nil {
                    notFilledFieldErrorMessage = IdentifiableString(text: "Для того, чтобы продолжить, Вам необходимо выбрать время, когда Вы придете в студию")
                } else if dateDetails.endTime == nil {
                    notFilledFieldErrorMessage = IdentifiableString(text: "Для того, чтобы продолжить, Вам необходимо выбрать время, когда Вы закончите работу в студии")
                } else {
                    shouldNavigateToNextScreen = true
                }
            }
        }
    }
    private var nextScreen: some View {
        AuthenticationView<ViewModel>()
    }
}

struct DayPickerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DayPickerView<ArrangementOrderDetails>()
                .preferredColorScheme(.dark)
                .environmentObject(Studio())
                .environmentObject(ArrangementOrderDetails())
        }
    }
}
