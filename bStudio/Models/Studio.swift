//
//  Studio.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 26.09.21.
//

import Foundation

class Studio: ObservableObject {
    var services: [Service] { Service.allCases }
    var vocalRecordingTypes: [VocalRecordingType] { VocalRecordingType.allCases }
    @Published var reservations: [Reservation] = []
    @Published var authors: [Author] = []
    @Published var workTimes: [String] = (6...23).map { "\($0):00" }
    var isStudioLoaded: Bool { !authors.isEmpty }
    
    // MARK: - Intents
    func getAuthors(for service: Service) -> [Author] {
        authors.filter { $0.services.contains(service) }
    }
    func loadStudio() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            self?.authors = [
                .init(name: "Kookah",
                      imageURL: "https://scontent-waw1-1.cdninstagram.com/v/t51.2885-15/sh0.08/e35/c0.180.1440.1440a/s640x640/140089689_272927090921061_5555409769371200460_n.jpg?_nc_ht=scontent-waw1-1.cdninstagram.com&_nc_cat=109&_nc_ohc=hbvbapZgevcAX-nrasn&tn=fAaKYngE5-px8oyw&edm=APU89FABAAAA&ccb=7-4&oh=792a373322fc403f53a751f8726a62e5&oe=6157C074&_nc_sid=86f79a",
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
                      ],
                      services: [.arrangement]),
                .init(name: "Никита SAYPINK!",
                      imageURL: "https://scontent-waw1-1.cdninstagram.com/v/t51.2885-15/sh0.08/e35/c2.0.1435.1435a/s640x640/233175680_508285140259395_9051338038596444189_n.jpg?_nc_ht=scontent-waw1-1.cdninstagram.com&_nc_cat=103&_nc_ohc=sgGQfEoSXbcAX8GRGjy&tn=fAaKYngE5-px8oyw&edm=ABfd0MgBAAAA&ccb=7-4&oh=6a6832d1fafba15ae8feb11d577b37bf&oe=6159176E&_nc_sid=7bff83",
                      arrangements: [
                        .init(name: "на заказ", price: "от 100$")
                      ],
                      songs: [],
                      services: [.arrangement]),
                .init(name: "Денис Грачёв",
                      imageURL: "https://scontent-waw1-1.cdninstagram.com/v/t51.2885-15/sh0.08/e35/c0.180.1440.1440a/s640x640/204769520_174334191327546_7776797308572425061_n.jpg?_nc_ht=scontent-waw1-1.cdninstagram.com&_nc_cat=106&_nc_ohc=JFDIX6-41LoAX_4gkXU&edm=ABfd0MgBAAAA&ccb=7-4&oh=15c04ec52955f34b7931cf3ac20db128&oe=6157B36F&_nc_sid=7bff83",
                      arrangements: [
                        .init(name: "wav", price: "30$"),
                        .init(name: "wav + дорожки", price: "50$"),
                        .init(name: "exclusive", price: "100$"),
                        .init(name: "на заказ", price: "от 100$")
                      ],
                      songs: [],
                      services: [.arrangement]),
                .init(name: "Ground",
                      imageURL: "https://scontent-waw1-1.cdninstagram.com/v/t51.2885-15/sh0.08/e35/c240.0.960.960a/s640x640/83944431_466492674232649_3436767051902357751_n.jpg?_nc_ht=scontent-waw1-1.cdninstagram.com&_nc_cat=105&_nc_ohc=Da8bklefpfwAX-S5mal&edm=APU89FABAAAA&ccb=7-4&oh=f0beb19cf12279f96d5e57c561145034&oe=61587838&_nc_sid=86f79a",
                      arrangements: [
                        .init(name: "на заказ", price: "от 100$")
                      ],
                      songs: [],
                      services: [.arrangement]),
                .init(name: "Герман",
                      imageURL: "https://scontent-waw1-1.cdninstagram.com/v/t51.2885-15/sh0.08/e35/s640x640/134513018_3678589655512920_2139400402784268642_n.jpg?_nc_ht=scontent-waw1-1.cdninstagram.com&_nc_cat=100&_nc_ohc=aR6Kvs3IuTMAX-bMSkl&edm=ABfd0MgBAAAA&ccb=7-4&oh=b9f75aac4c825691cdf3b91948455879&oe=6157A308&_nc_sid=7bff83",
                      masteringAndMixing: "стоимость работы - 15р в час",
                      songs: [
                        .init(imageURL: "https://cdn.promodj.com/afs/500166ff33a9cec4cae4435916a60dfb12:resize:2000x2000:same:3e0710",
                              userFriendlyName: "Linkin park - numb",
                              songName: "LinkinParkNumb"),
                        .init(imageURL: "https://i.pinimg.com/originals/06/a7/12/06a712582199ac56265fd413b2426fce.jpg",
                              userFriendlyName: "Linkin park - numb 2",
                              songName: "LinkinParkNumb")
                      ],
                      services: [.mixing, .mastering])
            ]
        }
    }
}
