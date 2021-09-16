//
//  UIExtensions.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 16.09.21.
//

import SwiftUI

extension Color {
    static var blueSmoke: Color = Color(red: 112 / 255, green: 141 / 255, blue: 129 / 255)
    static var background: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color.codeGray, Color.mineShaft]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
    }
    static var codeGray: Color = Color(red: 26 / 255, green: 26 / 255, blue: 26 / 255)
    static var mineShaft: Color = Color(red: 43 / 255, green: 43 / 255, blue: 43 / 255)
}
