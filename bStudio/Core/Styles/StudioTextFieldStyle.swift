//
//  StudioTextFieldStyle.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 21.09.21.
//

import SwiftUI

struct StudioTextFieldStyle<Placeholder>: TextFieldStyle where Placeholder: View {
    var shouldShow: Bool
    var placeholder: () -> Placeholder
    
    init(when shouldShow: Bool, placeholder: @escaping () -> Placeholder) {
        self.shouldShow = shouldShow
        self.placeholder = placeholder
    }
    
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .placeholder(when: shouldShow, placeholder: placeholder)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .overlay(RoundedRectangle(cornerRadius: 6).strokeBorder(lineWidth: 1))
            .foregroundColor(.white)
    }
}
