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
            VStack(alignment: .leading, spacing: 16) {
                content
                Spacer()
            }
            .padding(16)
            Spacer()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        title
        servicesView
            .padding(.leading, 8)
        next
    }
    private var title: some View {
        Text("Выберите услугу")
            .font(.system(size: 34, weight: .regular))
    }
    private var servicesView: some View {
        RadioButtonPicker(values: services, selectionIndex: $selectionIndex)
    }
    private var next: some View {
        Button {
            
        } label: {
            Text("Дальше")
                .font(.system(size: 18))
                .padding([.leading, .trailing], 16)
                .padding([.top, .bottom], 10)
//                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.blueSmoke, lineWidth: 2)
                )
        }
    }
}

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
