//
//  AuthorListView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 17.09.21.
//

import SwiftUI

struct AuthorListView: View {
    var authors: [Author]
    @State private var shouldShowMusicExamplesScreen = false
    @State private var shouldShowNextScreen = false
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                title
                ForEach(authors) { author in
                    card(for: author).padding(.leading, 8)
                }
            }
        }
        .padding(16)
        .background(Color.background.edgesIgnoringSafeArea([.bottom, .horizontal]))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("VOSTOK'7")
        .navigationBarColor(backgroundColor: .woodsmoke, titleColor: .white)
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
                name(author.name)
            }
            choose
            listen
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
    private var choose: some View {
        NavigationLink(destination: Text("Destination"), isActive: $shouldShowNextScreen) {
            RoundedButton(text: "Выбрать") {
                shouldShowNextScreen = true
            }
        }
    }
    private var listen: some View {
        NavigationLink(destination: Text("Destination"), isActive: $shouldShowMusicExamplesScreen) {
            Button {
                shouldShowMusicExamplesScreen = true
            } label: {
                Text("Слушать примеры работ")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.blueSmoke)
                    .font(.system(size: 20, weight: .semibold))
            }
        }
    }
}

struct AuthorListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AuthorListView(authors: [
                .init(name: "Kookah", imageURL: "https://scontent-waw1-1.cdninstagram.com/v/t51.2885-19/s320x320/187743888_141041974625853_7926547141536261314_n.jpg?_nc_ht=scontent-waw1-1.cdninstagram.com&_nc_ohc=bl6jqHYNIWEAX-NgH-3&tn=fAaKYngE5-px8oyw&edm=ABfd0MgBAAAA&ccb=7-4&oh=82e68ab4e43ec8e4b1ecd7b24f4fe4f9&oe=614AC5EE&_nc_sid=7bff83"),
                .init(name: "Никита SAYPINK!", imageURL: "https://scontent-waw1-1.cdninstagram.com/v/t51.2885-15/sh0.08/e35/c2.0.1435.1435a/s640x640/233175680_508285140259395_9051338038596444189_n.jpg?_nc_ht=scontent-waw1-1.cdninstagram.com&_nc_cat=103&_nc_ohc=6RJeEsMrEKAAX-6tsnD&tn=fAaKYngE5-px8oyw&edm=ABfd0MgBAAAA&ccb=7-4&oh=7b9a0b1e222d78c4bfb3d7367a4c25c3&oe=614B3FAE&_nc_sid=7bff83")
            ])
        }
    }
}
