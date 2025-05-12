//
//  playsound.swift
//  FitnessGo
//
//  Created by Yufei Yao on 15/10/2024.
//

import Foundation
import AVFoundation

class AudioPlayerClass {
    var audioPlayer: AVAudioPlayer?
    var runningPlayer: AVAudioPlayer?
    var cheeringPlayer: AVAudioPlayer?
    
    func playSound(named fileName: String) {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "wav") else {
            print("Sound file \(fileName) not found")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("cannot load the file \(fileName): \(error)")
        }
    }
    //play cheering and running  the same time
    func playCheeringSound() {
           guard let url = Bundle.main.url(forResource: "cheering", withExtension: "wav") else { return }
           do {
               cheeringPlayer = try AVAudioPlayer(contentsOf: url)
               cheeringPlayer?.play()
           } catch {
               print("cannot load cheering sound file: \(error)")
           }
       }
    func playCoinSound() {
        playSound(named: "coin")
    }
    
    func playLoseSound() {
        playSound(named: "lose")
    }
    //play running in a loop
    func playRunningSound() {
            guard let url = Bundle.main.url(forResource: "running", withExtension: "wav") else { return }
            do {
                runningPlayer = try AVAudioPlayer(contentsOf: url)
                runningPlayer?.numberOfLoops = -1
                runningPlayer?.play()
            } catch {
                print("cannot load running sound file: \(error)")
            }
        }
    
    func playWinSound() {
        playSound(named: "win")
    }
    
    func stopSound(){
        audioPlayer?.stop()
        runningPlayer?.stop()
        cheeringPlayer?.stop()
    }
}
