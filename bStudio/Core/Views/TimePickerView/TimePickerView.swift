//
//  TimePickerView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 24.09.21.
//

import SwiftUI

struct TimePickerView: View {
    
    @State private var selectedIndex: Int
    @Binding private var selection: String?
    private var title: String
    private var times: [WorkTime]

    init(title: String, selection: Binding<String?>, times: [WorkTime]) {
        self.title = title
        self._selection = selection
        self.times = times
        let initialIndex = Int(times.firstIndex(where: { $0.isEnabled }) ?? 0)
        _selectedIndex = State(initialValue: initialIndex)
    }

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            TimePickerField(times: times, lastSelectedIndex: $selectedIndex) {
                selection = times[selectedIndex].text
            }
        }
        .onAppear {
            selection = times[selectedIndex].text
        }
    }
}
