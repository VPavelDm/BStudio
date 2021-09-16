//
//  RoundedButton.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 16.09.21.
//

import SwiftUI

struct RoundedButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
    }
}
