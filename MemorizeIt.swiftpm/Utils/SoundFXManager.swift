//
//  HanvestSoundFXManager.swift
//  MemorizeIt
//
//  Created by Hans Arthur Cupiterson on 21/02/25.
//

import Foundation
import AVFoundation

@MainActor
struct SoundFXManager {
    private static var audioPlayer: AVAudioPlayer?
    
    static func playSound(soundFX: SoundFX) {
        guard let url = Bundle.main.url(forResource: soundFX.value, withExtension: "mp3") else {
            print("Sound \(soundFX.value) file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.volume = soundFX.volume
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                audioPlayer?.stop()
            })
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
}
