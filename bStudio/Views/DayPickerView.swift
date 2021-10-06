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
    @State private var showDiscontinuousWarning = false
    
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
        .alert(isPresented: $showDiscontinuousWarning) {
            Alert(title: Text("Обратите внимание"),
                  message: Text("Выбранный Вами диапазон времени прерывен, т.е. Вам необходимо будет прерваться, так как студия уже забронирована на промежуток времени внутри Вашего выбора."),
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
        VStack {
            TimePickerView(title: "Выберите время начала",
                           selection: $dateDetails.startTime,
                           times: studio.workTimes(for: dateDetails.selectionDate))
            TimePickerView(title: "Выберите время окончания",
                           selection: $dateDetails.endTime,
                           times: studio.workTimes(for: dateDetails.selectionDate))
        }
        .id(dateDetails.selectionDate)
        .onChange(of: dateDetails.startTime) { newValue in
            validateTimeRange()
        }
        .onChange(of: dateDetails.endTime) { newValue in
            validateTimeRange()
        }
    }
    private var next: some View {
        NavigationLink(destination: nextScreen, isActive: $shouldNavigateToNextScreen) {
            RoundedButton(text: "Дальше") {
                shouldNavigateToNextScreen = true
            }
        }
    }
    private var nextScreen: some View {
        AuthenticationView<ViewModel>()
    }
    
    // MARK: - Utils
    private func validateTimeRange() {
        guard let startTime = dateDetails.startTime else { return }
        guard let endTime = dateDetails.endTime else { return }
        let date = dateDetails.selectionDate
        if !studio.isDateRangeContinuous(startTime: startTime, endTime: endTime, date: date) {
            showDiscontinuousWarning = true
        }
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
