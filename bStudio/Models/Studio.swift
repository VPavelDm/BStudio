//
//  Studio.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 26.09.21.
//

import Foundation

class Studio: ObservableObject {
    var services: [Service] { Service.allCases }
    var reservations: [Reservation] = []
    @Published var authors: [Author] = []
    var isStudioLoaded: Bool { !authors.isEmpty }
    
    func loadStudio() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            self?.authors = [
                .init(name: "Kookah",
                      imageURL: "https://scontent-waw1-1.cdninstagram.com/v/t51.2885-19/s320x320/187743888_141041974625853_7926547141536261314_n.jpg?_nc_ht=scontent-waw1-1.cdninstagram.com&_nc_ohc=bl6jqHYNIWEAX-NgH-3&tn=fAaKYngE5-px8oyw&edm=ABfd0MgBAAAA&ccb=7-4&oh=82e68ab4e43ec8e4b1ecd7b24f4fe4f9&oe=614AC5EE&_nc_sid=7bff83",
                      arrangements: [
                        .init(name: "wav", price: "30$"),
                        .init(name: "wav + дорожки", price: "50$"),
                        .init(name: "exclusive", price: "100$"),
                        .init(name: "на заказ", price: "от 100$")
                      ],
                      songs: [
                        .init(imageURL: "https://cdn.promodj.com/afs/500166ff33a9cec4cae4435916a60dfb12:resize:2000x2000:same:3e0710",
                              userFriendlyName: "Linkin park - numb",
                              songName: "LinkinParkNumb"),
                        .init(imageURL: "https://i.pinimg.com/originals/06/a7/12/06a712582199ac56265fd413b2426fce.jpg",
                              userFriendlyName: "Linkin park - numb 2",
                              songName: "LinkinParkNumb")
                      ]),
                .init(name: "Никита SAYPINK!",
                      imageURL: "https://scontent-waw1-1.cdninstagram.com/v/t51.2885-15/sh0.08/e35/c2.0.1435.1435a/s640x640/233175680_508285140259395_9051338038596444189_n.jpg?_nc_ht=scontent-waw1-1.cdninstagram.com&_nc_cat=103&_nc_ohc=6RJeEsMrEKAAX-6tsnD&tn=fAaKYngE5-px8oyw&edm=ABfd0MgBAAAA&ccb=7-4&oh=7b9a0b1e222d78c4bfb3d7367a4c25c3&oe=614B3FAE&_nc_sid=7bff83",
                      arrangements: [
                        .init(name: "на заказ", price: "от 100$")
                      ],
                      songs: []),
                .init(name: "Денис Грачёв",
                      imageURL: "https://scontent-waw1-1.cdninstagram.com/v/t51.2885-15/sh0.08/e35/c0.180.1440.1440a/s640x640/204769520_174334191327546_7776797308572425061_n.jpg?_nc_ht=scontent-waw1-1.cdninstagram.com&_nc_cat=106&_nc_ohc=6Wyp14n_9FsAX8baNI4&edm=ABfd0MgBAAAA&ccb=7-4&oh=9d8990b3f2fb78ad4c5a1d9287470851&oe=614BD5EF&_nc_sid=7bff83",
                      arrangements: [
                        .init(name: "wav", price: "30$"),
                        .init(name: "wav + дорожки", price: "50$"),
                        .init(name: "exclusive", price: "100$"),
                        .init(name: "на заказ", price: "от 100$")
                      ],
                      songs: []),
                .init(name: "Денис Грачёв",
                      imageURL: "https://scontent-waw1-1.cdninstagram.com/v/t51.2885-15/sh0.08/e35/c240.0.960.960a/s640x640/88994837_3307208135960166_8329418424570694165_n.jpg?_nc_ht=scontent-waw1-1.cdninstagram.com&_nc_cat=106&_nc_ohc=OCGScNeVSfAAX9Bj4Sh&edm=APU89FABAAAA&ccb=7-4&oh=5bd389ad1760e5f2c5552edaed867834&oe=614B2A07&_nc_sid=86f79a",
                      arrangements: [
                        .init(name: "на заказ", price: "от 100$")
                      ],
                      songs: [])
            ]
        }
    }
}
