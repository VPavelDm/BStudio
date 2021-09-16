//
//  RoundedButton.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 16.09.21.
//

import SwiftUI

struct RoundedButton: View {
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 20, weight: .semibold))
                .padding([.leading, .trailing], 16)
                .padding([.top, .bottom], 10)
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.blueSmoke, lineWidth: 2)
                )
        }
    }
}
