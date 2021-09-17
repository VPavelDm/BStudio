//
//  AsyncImage.swift
//  Choice
//
//  Created by Pavel Vaitsikhouski on 21.08.21.
//

import SwiftUI

struct AsyncImage: View {
    @StateObject private var loader: ImageLoader
    @State private var uiImage: UIImage?
    
    init(url: URL) {
        let loader = ImageLoader(url: url, cache: Environment(\.imageCache).wrappedValue)
        _loader = StateObject(wrappedValue: loader)
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
            .onReceive(loader.$image) { image in
                withAnimation {
                    uiImage = image
                }
            }
    }
    
    @ViewBuilder
    private var content: some View {
        if let uiImage = uiImage {
            Image(uiImage: uiImage).resizable()
        } else {
            ZStack {
                Color.clear
                ProgressView()
            }
        }
    }
}
