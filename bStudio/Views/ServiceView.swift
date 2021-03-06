//
//  ServiceView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 16.09.21.
//

import SwiftUI

struct ServiceView: View {
    @StateObject private var studio: Studio = Studio()
    @StateObject private var bookingNavigation = BookingNavigation()
    @State private var selectionIndex = 0
    @State private var shouldShowProgressView = true
    
    var body: some View {
        NavigationView {
            content
                .padding(16)
                .bStudioNavigationBar(title: "VOSTOK'7")
                .onAppear {
                    studio.loadStudio()
                }
                .onReceive(studio.$authors) { authors in
                    withAnimation {
                        shouldShowProgressView = authors.isEmpty
                    }
                }
        }
        .environmentObject(studio)
        .environmentObject(bookingNavigation)
    }
    
    private var content: some View {
        ZStack {
            if shouldShowProgressView {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .xanadu))
            } else {
                VStack(alignment: .leading, spacing: 16) {
                    title
                    servicesView
                        .padding(.leading, .radioButtonsInset)
                    next
                    Spacer()
                }
            }
        }
    }
    private var title: some View {
        Text("Выберите услугу")
            .font(.system(size: .titleFontSize, weight: .title))
            .foregroundColor(.text)
    }
    private var servicesView: some View {
        RadioButtonPicker(values: studio.services.map { $0.title }, selectionIndex: $selectionIndex) { text in
            Text(text)
                .font(.system(size: .radioButtonFontSize, weight: .radioButton))
                .foregroundColor(.text)
        }
    }
    private var next: some View {
        NavigationLink(destination: nextScreen, isActive: $bookingNavigation.isBookingUnderway) {
            RoundedButton(text: "Дальше") {
                bookingNavigation.isBookingUnderway = true
            }
        }
    }
    
    @ViewBuilder
    private var nextScreen: some View {
        switch studio.services[selectionIndex] {
        case .arrangement:
            AuthorListView<ArrangementOrderDetails>(service: .arrangement)
        case .vocalRecording:
            VocalRecordingTypeView<VocalRecordingOrderDetails>()
        case .mixing:
            AuthorListView<MixingOrderDetails>(service: .mixing)
        case .mastering:
            AuthorListView<MixingOrderDetails>(service: .mastering)
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
        ServiceView()
    }
}

