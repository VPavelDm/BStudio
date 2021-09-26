//
//  bStudioApp.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 16.09.21.
//

import SwiftUI

@main
struct bStudioApp: App {
    @State var selection = Date()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                CalendarView(selection: $selection)
                    .preferredColorScheme(.dark)
            }
        }
    }
}
