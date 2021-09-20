//
//  AudioPlayer.swift
//  bStudio
//
//  Created by Pavel Vaitsikhouski on 18.09.21.
//

import SwiftUI
import AVFoundation

class AudioPlayer: NSObject, ObservableObject {
    
    // MARK: - Properties
    private var player: AVAudioPlayer
    private var displayLink: CADisplayLink?
    var isPlaying: Bool {
        player.isPlaying
    }
    
    // MARK: - Outputs
    @Published var progress: Double = 0
    
    // MARK: - Inits
    init?(songName: String) {
        guard let url = Bundle.main.url(forResource: songName, withExtension: "mp3") else { return nil }
        guard let player = try? AVAudioPlayer(contentsOf: url) else { return nil }
        self.player = player
        
        super.init()
        
        self.setupDisplayLink()
        self.setupPlayer()
    }
    deinit {
        displayLink?.invalidate()
    }
    
    // MARK: - Setup
    private func setupDisplayLink() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateDisplay))
        displayLink?.add(to: .current, forMode: .default)
        displayLink?.isPaused = true
    }
    @objc private func updateDisplay() {
        progress = player.currentTime / player.duration
    }
    private func setupPlayer() {
        player.delegate = self
    }
    
    // MARK: - Intents
    func play() {
        guard !isPlaying else { return }
        objectWillChange.send()
        player.play()
        displayLink?.isPaused = false
    }
    func stop() {
        guard isPlaying else { return }
        objectWillChange.send()
        player.stop()
        displayLink?.isPaused = true
    }
}

extension AudioPlayer: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        displayLink?.isPaused = true
    }
}
