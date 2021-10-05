//
//  TimePickerView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 24.09.21.
//

import SwiftUI

struct TimePickerView: View {
    
    @State private var selectedIndex = 0
    @Binding private var selection: String?
    private var title: String
    private var times: [String]

    init(title: String, selection: Binding<String?>, times: [String]) {
        self.title = title
        self._selection = selection
        self.times = times
    }

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            TimePickerField(data: times,
                            lastSelectedIndex: $selectedIndex)
        }
        .onAppear {
            selection = times[selectedIndex]
        }
    }
}
