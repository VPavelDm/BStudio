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
    @State private var shouldShowWarning: Warning?
    
    var body: some View {
        VStack(alignment: .leading) {
            title.padding([.horizontal, .top], 16)
            ScrollView {
                content
                    .padding([.horizontal, .bottom], 16)
            }
        }
        .bStudioNavigationBar(title: "VOSTOK'7")
        .alert(item: $shouldShowWarning, content: { warning in
            Alert(title: Text(warning.title),
                  message: Text(warning.description),
                  dismissButton: .cancel(Text("Понятно")))
        })
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
        CalendarView(selection: $dateDetails.selectionDate)
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
    }
    private var next: some View {
        NavigationLink(destination: nextScreen, isActive: $shouldNavigateToNextScreen) {
            RoundedButton(text: "Дальше") {
                if !isTimeRangeContinuous() {
                    shouldShowWarning = .overlapsDateRange
                } else if !isStartTimeLessThanEndTime() {
                    shouldShowWarning = .incorrectInput
                } else {
                    shouldNavigateToNextScreen = true
                }
            }
        }
    }
    private var nextScreen: some View {
        AuthenticationView<ViewModel>()
    }
    
    // MARK: - Utils
    private func isTimeRangeContinuous() -> Bool {
        guard let startTime = dateDetails.startTime else { return false }
        guard let endTime = dateDetails.endTime else { return false }
        let date = dateDetails.selectionDate
        return studio.isDateRangeContinuous(startTime: startTime, endTime: endTime, date: date)
    }
    private func isStartTimeLessThanEndTime() -> Bool {
        guard let startTime = dateDetails.startTime else { return false }
        guard let endTime = dateDetails.endTime else { return false }
        let startDate = DateMapper(time: startTime, date: dateDetails.selectionDate).serverTime
        let endDate = DateMapper(time: endTime, date: dateDetails.selectionDate).serverTime
        return startDate < endDate
    }
    private enum Warning: Identifiable {
        var id: Warning { self }
        
        case incorrectInput
        case overlapsDateRange
        
        var title: String {
            switch self {
            case .incorrectInput:
                return "Ошибка ввода данных"
            case .overlapsDateRange:
                return "Ошибка ввода данных"
            }
        }
        var description: String {
            switch self {
            case .incorrectInput:
                return "Вы выбрали неверный промежуток времени: время окончания работы должно быть больше времени начала!"
            case .overlapsDateRange:
                return "Вы выбрали неверный промежуток времени: между временем начала и окончания работы не должно быть зарезервировано другими людьми!"
            }
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
