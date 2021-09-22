//
//  bStudioApp.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 16.09.21.
//

import SwiftUI

@main
struct bStudioApp: App {
    var body: some Scene {
        WindowGroup {
            CalendarView()
                .accentColor(.white)
                .background(Color.background.edgesIgnoringSafeArea([.bottom, .horizontal]))
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("VOSTOK'7")
                .navigationBarColor(backgroundColor: .woodsmoke, titleColor: .white)
        }
    }
}
