//
//  AudioManager.swift
//  SingElingPrototype
//
//  Created by Bintang Anandhiya on 19/10/24.
//

import Foundation
import AVFoundation

var clickPlayer: AVAudioPlayer?
var wrongPlayer: AVAudioPlayer?
var correctPlayer: AVAudioPlayer?
var audioPlayer: AVAudioPlayer?
var announcementPlayer: AVAudioPlayer?

func playClick() {
    if let soundURL = Bundle.main.url(forResource: "buttonClick", withExtension: "mp3") {
        do {
            clickPlayer = try AVAudioPlayer(contentsOf: soundURL)
            clickPlayer?.play()
        } catch {
            print("Failed to play sound: \(error.localizedDescription)")
        }
    }
}

func playSoundResultWrong() {
    if let soundURL = Bundle.main.url(forResource: "resultWrong", withExtension: "mp3") {
        do {
            wrongPlayer = try AVAudioPlayer(contentsOf: soundURL)
            wrongPlayer?.play()
        } catch {
            print("Failed to play sound: \(error.localizedDescription)")
        }
    }
}

func playSoundResultCorrect() {
    if let soundURL = Bundle.main.url(forResource: "resultCorrect", withExtension: "mp3") {
        do {
            correctPlayer = try AVAudioPlayer(contentsOf: soundURL)
            correctPlayer?.play()
        } catch {
            print("Failed to play sound: \(error.localizedDescription)")
        }
    }
}

func playWinnerSound() {
    if let soundURL = Bundle.main.url(forResource: "congratulations", withExtension: "mp3") {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    } else {
        print("Sound file not found in main bundle")
    }
}


func playAnnounceSound() {
    if let soundURL = Bundle.main.url(forResource: "Iphone Notification Sound 5", withExtension: "mp3") {
        do {
            announcementPlayer = try AVAudioPlayer(contentsOf: soundURL)
            announcementPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    } else {
        print("Sound file not found in main bundle")
    }
}
