//
//  RadioButtonPicker.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 16.09.21.
//

import SwiftUI

struct RadioButtonPicker<RowView>: View where RowView: View {
    var values: [String]
    @Binding var selectionIndex: Int
    var customizeRow: (String) -> RowView
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(values.indices, id: \.self) { index in
                row(values[index], index: index)
                    .onTapGesture {
                        withAnimation {
                            selectionIndex = index
                        }
                    }
            }
        }
    }
    
    private func row(_ text: String, index: Int) -> some View {
        HStack {
            RadioButton(isSelected: selectionIndex == index)
            customizeRow(text)
        }
    }
    
}

struct RadioButtonPicker_Previews: PreviewProvider {
    
    struct Content: View {
        @State var selectionIndex = 0
        var body: some View {
            RadioButtonPicker(values: ["first", "second", "third"],
                              selectionIndex: $selectionIndex) { Text($0) }

        }
    }
    static var previews: some View {
        Content()
    }
}
