//
//  AudioPlayer.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 18.09.21.
//

import SwiftUI
import AVFoundation

class AudioPlayer: ObservableObject {
    
    // MARK: - Properties
    private var player: AVAudioPlayer
    var isPlaying: Bool {
        player.isPlaying
    }
    
    // MARK: - Inits
    init?(songName: String) {
        guard let url = Bundle.main.url(forResource: songName, withExtension: "mp3") else { return nil }
        guard let player = try? AVAudioPlayer(contentsOf: url) else { return nil }
        self.player = player
    }
    
    // MARK: - Intents
    func changeControlState() {
        objectWillChange.send()
        if isPlaying {
            player.stop()
        } else {
            player.play()
        }
    }
}
