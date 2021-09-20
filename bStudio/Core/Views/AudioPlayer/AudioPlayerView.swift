//
//  AudioPlayerView.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 18.09.21.
//

import SwiftUI

struct AudioPlayerView: View {
    @ObservedObject var player: AudioPlayer
    var song: Song
    
    init(song: Song) {
        self.song = song
        self.player = AudioPlayer(songName: song.songName)!
        if !player.isPlaying {
            player.play()
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            HStack(spacing: .cardInnerSpacing) {
                audioAvatar(song.imageURL)
                audioName(song.userFriendlyName)
                Spacer()
                controlButton
            }
            .padding(.contentPadding)
            ProgressView(value: player.progress)
                .progressViewStyle(LinearProgressViewStyle(tint: .white))
                .padding(.horizontal, .contentPadding)
        }
        .background(Color.audioPlayerBackground)
        .cornerRadius(.playerCornerRadius)
        .onDisappear {
            player.stop()
        }
    }
    private func audioAvatar(_ url: URL) -> some View {
        AsyncImage(url: url)
            .frame(width: .avatarSize, height: .avatarSize)
            .cornerRadius(.avatarCornerRadius)
    }
    private func audioName(_ text: String) -> some View {
        Text(text)
            .font(.audioName)
            .foregroundColor(.textColor)
    }
    private var controlButton: some View {
        Button {
            if player.isPlaying {
                player.stop()
            } else {
                player.play()
            }
        } label: {
            Image(systemName: player.isPlaying ? "pause.fill" : "play.fill")
                .resizable()
                .frame(width: .controlButtonSize, height: .controlButtonSize)
                .foregroundColor(.textColor)
                .padding()
        }
    }
}

// MARK: - Drawing Constants
fileprivate extension CGFloat {
    static var avatarSize: CGFloat = 50
    static var avatarCornerRadius: CGFloat = avatarSize / 5
    static var controlButtonSize: CGFloat = avatarSize / 2.5
    static var playerCornerRadius: CGFloat = 8
    static var cardInnerSpacing: CGFloat = 12
    static var contentPadding: CGFloat = 8
}
fileprivate extension Font {
    static var audioName: Font = .system(size: 20, weight: .heavy)
}

// MARK: - Preview
struct AudioPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        AudioPlayerView(
            song: .init(
                imageURL: "https://cdn.promodj.com/afs/500166ff33a9cec4cae4435916a60dfb12:resize:2000x2000:same:3e0710",
                userFriendlyName: "Linkin park - numb",
                songName: "LinkinParkNumb")
        )
    }
}
