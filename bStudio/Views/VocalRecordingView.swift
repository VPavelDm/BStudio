//
//  VocalRecordingView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 26.09.21.
//

import SwiftUI

struct VocalRecordingView: View {
    @EnvironmentObject private var studio: Studio
    @State private var selectionIndex: Int = 0
    @State private var shouldNavigateToNextScreen = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            title
            Group {
                description
                servicesView
                next
            }
            .padding(.horizontal, 8)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(16)
        .background(Color.background.edgesIgnoringSafeArea([.bottom, .horizontal]))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("VOSTOK'7")
        .navigationBarColor(backgroundColor: .woodsmoke, titleColor: .white)
    }
    private var title: some View {
        Text("Детали записи")
            .font(.system(size: 34, weight: .regular))
            .foregroundColor(.white)
    }
    private var description: some View {
        Text("Что будете записывать?*")
            .font(.system(size: 20, weight: .regular))
            .foregroundColor(.white)
    }
    private var servicesView: some View {
        RadioButtonPicker(
            values: studio.vocalRecordingTypes.map { $0.title },
            selectionIndex: $selectionIndex
        ) { text in
            Text(text)
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(.textColor)
        }
    }
    private var next: some View {
        NavigationLink(destination: Text("Hello"), isActive: $shouldNavigateToNextScreen) {
            RoundedButton(text: "Дальше") {
//                if orderDetails.songs.first?.isEmpty ?? true {
//                    shouldShowNotFilledAlert = true
//                } else {
//                    shouldNavigateToNextScreen = true
//                }
            }
        }
    }

}

struct VocalRecordingView_Previews: PreviewProvider {
    static var previews: some View {
        VocalRecordingView()
            .environmentObject(Studio())
    }
}
