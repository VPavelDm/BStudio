//
//  BStudioNavigationBar.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 8.10.21.
//

import Foundation
import SwiftUI

struct BStudioNavigationBar: ViewModifier {
    var title: String
    
    func body(content: Content) -> some View {
        content
            .navigationBarColor(backgroundColor: .woodsmoke, titleColor: .white)
            .background(Color.background.edgesIgnoringSafeArea([.bottom, .horizontal]))
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(title)
    }
}

extension View {
    func bStudioNavigationBar(title: String) -> some View {
        modifier(BStudioNavigationBar(title: title))
    }
}
