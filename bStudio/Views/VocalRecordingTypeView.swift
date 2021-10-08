//
//  VocalRecordingTypeView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 26.09.21.
//

import SwiftUI

protocol VocalRecordingTypeDetails: ObservableObject {
    var selectionIndex: Int { get set }
    var otherText: String { get set }
}

struct VocalRecordingTypeView<ViewModel>: View where ViewModel: VocalRecordingTypeDetails {
    @EnvironmentObject private var studio: Studio
    @EnvironmentObject private var vocalRecordingTypeDetails: ViewModel
    @State private var shouldNavigateToNextScreen = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            title
            Group {
                description
                servicesView
                if vocalRecordingTypeDetails.selectionIndex == 2 {
                    otherField
                }
                next
            }
            .padding(.horizontal, 8)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(16)
        .bStudioNavigationBar(title: "VOSTOK'7")
    }
    private var title: some View {
        Text("Детали записи")
            .font(.system(size: 34, weight: .regular))
            .foregroundColor(.white)
    }
    private var description: some View {
        Text("Что будете записывать?*")
            .font(.system(size: 20, weight: .regular))
            .foregroundColor(.white)
    }
    private var servicesView: some View {
        RadioButtonPicker(
            values: studio.vocalRecordingTypes.map { $0.title },
            selectionIndex: $vocalRecordingTypeDetails.selectionIndex
        ) { text in
            Text(text)
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(.textColor)
        }
    }
    private var otherField: some View {
        TextField("", text: $vocalRecordingTypeDetails.otherText)
            .textFieldStyle(StudioTextFieldStyle(when: false) { Text("") })
            .transition(.move(edge: .top))
    }
    private var next: some View {
        NavigationLink(destination: calendarView, isActive: $shouldNavigateToNextScreen) {
            RoundedButton(text: "Дальше") {
                shouldNavigateToNextScreen = true
            }
            .background(Color.eerieBlack)
        }
    }
    private var calendarView: some View {
        DayPickerView<VocalRecordingOrderDetails>()
    }

}

struct VocalRecordingView_Previews: PreviewProvider {
    static var previews: some View {
        VocalRecordingTypeView<VocalRecordingOrderDetails>()
            .environmentObject(Studio())
            .environmentObject(VocalRecordingOrderDetails())
    }
}
