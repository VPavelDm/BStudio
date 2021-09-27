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
            ContentView()
                .preferredColorScheme(.dark)
                .environmentObject(Studio())
                .environmentObject(ArrangementOrderDetails())
                .environmentObject(VocalRecordingDetails())
        }
    }
}
