//
//  ProvidedView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 16.09.21.
//

import SwiftUI

struct ProvidedView: View {
    var body: some View {
        HStack(spacing: 4) {
            Text("provided by")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.white)
            Image("bStudio")
                .resizable()
                .frame(width: 47, height: 14)
        }
    }
}
