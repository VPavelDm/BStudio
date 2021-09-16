//
//  ContentView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 16.09.21.
//

import SwiftUI

struct ContentView: View {
    @State private var services = ["Написание аранжировки",
                                   "Запись вокала",
                                   "Сведение",
                                   "Мастеринг"]
    
    var body: some View {
        NavigationView {
            VStack {
                ServiceView(services: $services)
                Spacer()
                ProvidedView()
            }
            .background(Color.background.edgesIgnoringSafeArea([.bottom, .horizontal]))
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("VOSTOK'7")
            .navigationBarColor(backgroundColor: .woodsmoke, titleColor: .white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
