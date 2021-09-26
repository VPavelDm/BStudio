//
//  ServiceView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 16.09.21.
//

import SwiftUI

struct ServiceView: View {
    private let services: [Service] = Service.allCases
    @State private var shouldNavigateToNextScreen = false
    @State private var selectionIndex = 0
    
    var body: some View {
        Group {
            content
        }
        .padding(16)
        .navigationBarColor(backgroundColor: .woodsmoke, titleColor: .white)
    }
    
    @ViewBuilder
    private var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            title
            servicesView
                .padding(.leading, .radioButtonsInset)
            next
            Spacer()
        }
    }
    private var title: some View {
        Text("Выберите услугу")
            .font(.system(size: .titleFontSize, weight: .title))
            .foregroundColor(.text)
    }
    private var servicesView: some View {
        RadioButtonPicker(values: services.map { $0.title }, selectionIndex: $selectionIndex) { text in
            Text(text)
                .font(.system(size: .radioButtonFontSize, weight: .radioButton))
                .foregroundColor(.text)
        }
    }
    private var next: some View {
        NavigationLink(destination: nextScreen, isActive: $shouldNavigateToNextScreen) {
            RoundedButton(text: "Дальше") {
                shouldNavigateToNextScreen = true
            }
        }
    }
    
    @ViewBuilder
    private var nextScreen: some View {
        switch services[selectionIndex] {
        case .arrangement:
            AuthorListView(authors: [])
        case .vocalRecording:
            MusicListView(songs: [])
        case .mixing:
            MusicListView(songs: [])
        case .mastering:
            DayPickerView()
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

// MARK: - Previews
struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

