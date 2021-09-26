//
//  ContentView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 16.09.21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                ServiceView()
                Spacer()
                ProvidedView()
            }
            .background(Color.background.edgesIgnoringSafeArea([.bottom, .horizontal]))
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("VOSTOK'7")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
