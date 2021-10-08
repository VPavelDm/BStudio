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
            ServiceView()
                .preferredColorScheme(.dark)
                .accentColor(.white)
                .navigationViewStyle(StackNavigationViewStyle())
                .environmentObject(ArrangementOrderDetails())
                .environmentObject(VocalRecordingOrderDetails())
                .environmentObject(MixingOrderDetails())
        }
    }
}
