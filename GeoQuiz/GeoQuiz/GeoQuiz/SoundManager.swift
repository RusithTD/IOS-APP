import Foundation
import AVFoundation

// Simple singleton wrapper around AVAudioPlayer to play short sound effects
final class SoundManager {
    static let shared = SoundManager()

    private var tickPlayer: AVAudioPlayer?
    private var gameOverPlayer: AVAudioPlayer?
    private var successPlayer: AVAudioPlayer?

    private init() {
        tickPlayer = loadPlayer(named: "tick")
        gameOverPlayer = loadPlayer(named: "gameover")
        successPlayer = loadPlayer(named: "success")
    }

    private func loadPlayer(named name: String) -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "wav") ??
                        Bundle.main.url(forResource: name, withExtension: "mp3") else {
            return nil
        }

        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            return player
        } catch {
            return nil
        }
    }

    func playTick() {
        tickPlayer?.currentTime = 0
        tickPlayer?.play()
    }

    func playGameOver() {
        gameOverPlayer?.currentTime = 0
        gameOverPlayer?.play()
    }

    func playSuccess() {
        successPlayer?.currentTime = 0
        successPlayer?.play()
    }
}
