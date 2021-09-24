//
//  RadioButton.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 16.09.21.
//

import SwiftUI

struct RadioButton: View {
    var isSelected: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.white)
                .opacity(isSelected ? 1.0 : 0.0)
            Circle()
                .strokeBorder(Color.xanadu, lineWidth: isSelected ? DrawingConstrants.selectedLineWidth : DrawingConstrants.lineWidth)
        }
        .frame(width: DrawingConstrants.radius, height: DrawingConstrants.radius)
    }
    
    struct DrawingConstrants {
        static var radius: CGFloat = 20
        static var selectedLineWidth: CGFloat = 7
        static var lineWidth: CGFloat = 2
    }
}
