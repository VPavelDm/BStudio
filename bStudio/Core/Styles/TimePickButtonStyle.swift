//
//  TimePickButtonStyle.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 24.09.21.
//

import SwiftUI

struct TimePickButtonStyle: ButtonStyle {
    var isSelected: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .foregroundColor(.white)
            .background(
                Group {
                    if isSelected {
                        Color.selectedTimeCardBackground
                    } else if configuration.isPressed {
                        Color.highlightTimeCardBackground
                    } else {
                        Color.timeCardBackground
                    }
                }
            )
    }
    
}
