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

let songs: [Song] = [
    .init(imageURL: "https://cdn.promodj.com/afs/500166ff33a9cec4cae4435916a60dfb12:resize:2000x2000:same:3e0710",
          userFriendlyName: "Linkin park - numb",
          songName: "LinkinParkNumb"),
    .init(imageURL: "https://i.pinimg.com/originals/06/a7/12/06a712582199ac56265fd413b2426fce.jpg",
          userFriendlyName: "Linkin park - numb 2",
          songName: "LinkinParkNumb")
]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
