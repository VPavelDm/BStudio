//
//  TextField+placeholder.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 21.09.21.
//

import SwiftUI

struct TextFieldPlaceholder<Placeholder>: ViewModifier where Placeholder: View {
    var shouldShow: Bool
    var placeholder: () -> Placeholder
    
    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if shouldShow {
                placeholder()
            }
            content
        }
    }
}

extension View {
    func placeholder<Placeholder: View>(when shouldShow: Bool, @ViewBuilder placeholder: @escaping () -> Placeholder) -> some View {
        modifier(TextFieldPlaceholder(shouldShow: shouldShow, placeholder: placeholder))
    }
}
