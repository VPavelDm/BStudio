//
//  UIExtensions.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 16.09.21.
//

import SwiftUI

extension Color {
    static var blueSmoke: Color = Color(red: 112 / 255, green: 141 / 255, blue: 129 / 255)
    static var codeGray: Color = Color(red: 26 / 255, green: 26 / 255, blue: 26 / 255)
    static var mineShaft: Color = Color(red: 43 / 255, green: 43 / 255, blue: 43 / 255)
    static var woodsmoke: Color = Color(.woodsmoke)
    
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
        LinearGradient(gradient: Gradient(colors: [Color.codeGray, Color.mineShaft]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
    }
    static var audioCardBackground: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color(hex: "#343434"), Color(hex: "#444444")]),
                       startPoint: .bottomLeading,
                       endPoint: .topTrailing)
    }
}
extension UIColor {
    static var textColor: UIColor = .white
    static var navBarBackground: UIColor = .woodsmoke
}
