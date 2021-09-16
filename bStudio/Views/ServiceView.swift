//
//  ServiceView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 16.09.21.
//

import SwiftUI

struct ServiceView: View {
    @Binding var services: [String]
    var onClick: (Int) -> Void
    @State private var selectionIndex = 0
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: .contentInset) {
                content
                Spacer()
            }
            .padding(.contentInset)
            Spacer()
        }
        .background(Color.background.ignoresSafeArea())
    }
    
    @ViewBuilder
    private var content: some View {
        title
        servicesView
            .padding(.leading, .radioButtonsInset)
        next
    }
    private var title: some View {
        Text("Выберите услугу")
            .font(.system(size: .titleFontSize, weight: .title))
            .foregroundColor(.text)
    }
    private var servicesView: some View {
        RadioButtonPicker(values: services, selectionIndex: $selectionIndex) { text in
            Text(text)
                .font(.system(size: .radioButtonFontSize, weight: .radioButton))
                .foregroundColor(.text)
        }
    }
    private var next: some View {
        RoundedButton(text: "Дальше") {
            
        }
    }
}

// MARK: - Drawing constants
fileprivate extension CGFloat {
    static var titleFontSize: CGFloat = 34
    static var radioButtonFontSize: CGFloat = 20
    static var contentInset: CGFloat = 16
    static var radioButtonsInset: CGFloat = 8
}
fileprivate extension Color {
    static var text: Color = Color.white
}
fileprivate extension Font.Weight {
    static var title: Font.Weight = .regular
    static var radioButton: Font.Weight = .regular
}

// MARK: - Preview
struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        let services = ["Написание аранжировки",
                        "Запись вокала",
                        "Сведение",
                        "Мастеринг"]
        return ServiceView(services: .constant(services)) { index in
            
        }
    }
}
