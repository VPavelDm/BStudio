//
//  UIExtensions.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 16.09.21.
//

import SwiftUI

extension Color {
    static var xanadu: Color = Color(red: 112 / 255, green: 141 / 255, blue: 129 / 255)
    static var eerieBlack: Color = Color(red: 26 / 255, green: 26 / 255, blue: 26 / 255)
    static var charlestonGreen: Color = Color(red: 43 / 255, green: 43 / 255, blue: 43 / 255)
    static var woodsmoke: Color = Color(.woodsmoke)
    static var tertiaryLabel: Color = Color(.tertiaryLabel)
    static var davysGrey: Color = Color(hex: "535353")
    static var graniteGray: Color = Color(hex: "636363")
    
    init(hex: String) {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count != 6 {
            self = Color.gray
        } else {
            var rgbValue: UInt64 = 0
            Scanner(string: cString).scanHexInt64(&rgbValue)
            
            self = Color(
                red: Double((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: Double((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: Double(rgbValue & 0x0000FF) / 255.0
            )
        }
    }
}

extension UIColor {
    static var woodsmoke: UIColor = UIColor(red: 17 / 255, green: 17 / 255, blue: 18 / 255, alpha: 1.0)
}

// MARK: - Drawing constants
extension Font {
    static var titleFont: Font = .system(size: 34, weight: .regular)
}
extension Color {
    static var textColor: Color = .white
    static var background: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color.eerieBlack, Color.charlestonGreen]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
    }
    static var audioCardBackground: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color(hex: "#343434"), Color(hex: "#444444")]),
                       startPoint: .bottomLeading,
                       endPoint: .topTrailing)
    }
    static var audioPlayerBackground: Color = Color(hex: "#555555")
    static var timeCardBackground: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [.davysGrey, .graniteGray]),
                       startPoint: .bottomLeading,
                       endPoint: .topTrailing)
    }
    static var highlightTimeCardBackground: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [.xanadu.opacity(0.5)]),
                       startPoint: .bottomLeading,
                       endPoint: .topTrailing)
    }
    static var selectedTimeCardBackground: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [.xanadu]),
                       startPoint: .bottomLeading,
                       endPoint: .topTrailing)
    }
}
extension UIColor {
    static var textColor: UIColor = .white
    static var navBarBackground: UIColor = .woodsmoke
}
