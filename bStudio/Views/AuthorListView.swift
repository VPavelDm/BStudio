//
//  AuthorListView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 17.09.21.
//

import SwiftUI

struct AuthorListView: View {
    @EnvironmentObject private var studio: Studio
    @State private var shouldShowMusicExamplesScreen = false
    @State private var shouldShowNextScreen = false
    
    var body: some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.background.edgesIgnoringSafeArea([.bottom, .horizontal]))
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("VOSTOK'7")
            .navigationBarColor(backgroundColor: .woodsmoke, titleColor: .white)
    }
    
    private var content: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                title
                ForEach(studio.authors) { author in
                    card(for: author).padding(.leading, 8)
                }
            }
            .padding(16)
        }
    }
    private var title: some View {
        Text("Выберите автора")
            .font(.system(size: 34, weight: .regular))
            .foregroundColor(.white)
    }
    private func card(for author: Author) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 16) {
                image(author.imageURL)
                VStack(alignment: .leading, spacing: 8) {
                    name(author.name)
                    VStack(spacing: 0) {
                        ForEach(author.arrangements) { arrangement in
                            description(arrangement)
                        }
                    }
                }
            }
            choose
            listen(author: author)
        }
    }
    private func image(_ url: URL) -> some View {
        AsyncImage(url: url)
            .frame(width: 132, height: 132)
            .cornerRadius(8)
    }
    private func name(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 24, weight: .semibold))
            .foregroundColor(.white)
    }
    private func description(_ arrangement: Arrangement) -> some View {
        HStack {
            Text(arrangement.name)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .regular))
            Spacer()
            Text(arrangement.price)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .regular))
        }
    }
    private var choose: some View {
        NavigationLink(destination: detailsView, isActive: $shouldShowNextScreen) {
            RoundedButton(text: "Выбрать") {
                shouldShowNextScreen = true
            }
        }
    }
    private var detailsView: some View {
        DetailsView()
            .environmentObject(OrderDetails())
    }
    private func listen(author: Author) -> some View {
        NavigationLink(destination: MusicListView(songs: author.songs), isActive: $shouldShowMusicExamplesScreen) {
            Button {
                shouldShowMusicExamplesScreen = true
            } label: {
                Text("Слушать примеры работ")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.xanadu)
                    .font(.system(size: 20, weight: .semibold))
            }
        }
    }
}

struct AuthorListView_Previews: PreviewProvider {
    static var studio: Studio {
        let studio = Studio()
        studio.authors = [
            .init(name: "Kookah",
                  imageURL: "https://scontent-waw1-1.cdninstagram.com/v/t51.2885-19/s320x320/187743888_141041974625853_7926547141536261314_n.jpg?_nc_ht=scontent-waw1-1.cdninstagram.com&_nc_ohc=bl6jqHYNIWEAX-NgH-3&tn=fAaKYngE5-px8oyw&edm=ABfd0MgBAAAA&ccb=7-4&oh=82e68ab4e43ec8e4b1ecd7b24f4fe4f9&oe=614AC5EE&_nc_sid=7bff83",
                  arrangements: [
                    .init(name: "wav", price: "30$"),
                    .init(name: "wav + дорожки", price: "50$"),
                    .init(name: "exclusive", price: "100$"),
                    .init(name: "на заказ", price: "от 100$")
                  ],
                  songs: []),
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
        return studio
    }
    static var previews: some View {
        NavigationView {
            AuthorListView()
                .environmentObject(studio)
        }
    }
}
