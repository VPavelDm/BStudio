//
//  MusicListView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 17.09.21.
//

import SwiftUI

struct MusicListView: View {
    @State private var chosenSong: Song?
    var songs: [Song]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack {
                    title
                    LazyVStack(alignment: .leading, spacing: .cardsSpacing) {
                        ForEach(songs) { song in
                            card(for: song)
                        }
                    }
                    .padding(.horizontal, 8)
                }
                .padding(16)
                if chosenSong != nil {
                    Color.clear.frame(height: 70)
                }
            }
            if let song = chosenSong {
                AudioPlayerView(song: song).padding(8)
            }
        }
        .background(Color.background.edgesIgnoringSafeArea([.bottom, .horizontal]))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("VOSTOK'7")
        .navigationBarColor(backgroundColor: .navBarBackground, titleColor: .textColor)
    }
    private var title: some View {
        HStack {
            Text("Примеры работ")
                .font(.titleFont)
                .foregroundColor(.textColor)
            Spacer()
        }
    }
    private func card(for song: Song) -> some View {
        HStack(spacing: .cardInnerSpacing) {
            avatar(song.imageURL)
            audioName(song.userFriendlyName)
            Spacer()
        }
        .background(Color.audioCardBackground)
        .cornerRadius(.cardCornerRadius)
        .onTapGesture {
            chosenSong = song
        }
    }
    private func avatar(_ url: URL) -> some View {
        AsyncImage(url: url)
            .frame(width: .avatarSize, height: .avatarSize)
    }
    private func audioName(_ text: String) -> some View {
        Text(text)
            .font(.system(size: .audioNameFontSize, weight: .heavy))
            .foregroundColor(.textColor)
    }
}

// MARK: - Drawing constants
fileprivate extension CGFloat {
    static var cardCornerRadius: CGFloat = 8
    static var cardInnerSpacing: CGFloat = 16
    static var avatarSize: CGFloat = 80
    static var audioNameFontSize: CGFloat = 20
    static var cardsSpacing: CGFloat = 24
}

// MARK: - Preview
struct MusicListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MusicListView(songs: [
                .init(imageURL: "https://cdn.promodj.com/afs/500166ff33a9cec4cae4435916a60dfb12:resize:2000x2000:same:3e0710",
                      userFriendlyName: "Linkin park - numb",
                      songName: "LinkinParkNumb"),
                .init(imageURL: "https://i.pinimg.com/originals/06/a7/12/06a712582199ac56265fd413b2426fce.jpg",
                      userFriendlyName: "Linkin park - numb",
                      songName: "LinkinParkNumb"),
                .init(imageURL: "https://cdn.promodj.com/afs/500166ff33a9cec4cae4435916a60dfb12:resize:2000x2000:same:3e0710",
                      userFriendlyName: "Linkin park - numb",
                      songName: "LinkinParkNumb"),
                .init(imageURL: "https://i.pinimg.com/originals/06/a7/12/06a712582199ac56265fd413b2426fce.jpg",
                      userFriendlyName: "Linkin park - numb",
                      songName: "LinkinParkNumb"),
                .init(imageURL: "https://cdn.promodj.com/afs/500166ff33a9cec4cae4435916a60dfb12:resize:2000x2000:same:3e0710",
                      userFriendlyName: "Linkin park - numb",
                      songName: "LinkinParkNumb"),
                .init(imageURL: "https://i.pinimg.com/originals/06/a7/12/06a712582199ac56265fd413b2426fce.jpg",
                      userFriendlyName: "Linkin park - numb",
                      songName: "LinkinParkNumb")
            ])
        }
    }
}
