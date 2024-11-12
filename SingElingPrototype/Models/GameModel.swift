//
//  GameModel.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 22/10/24.
//

import Foundation
import SwiftUI

// MARK: - SendableGameDataType Enum
enum SendableGameDataType: Codable {
    case gameCommand, gameState
}

// MARK: - GameCommandType Enum
enum GameCommandType: Codable {
    case assignPID, cardPosShiftRight, cardPosShiftLeft, hideOthersCards, showOthersCards, invokeNextTurn
}

// MARK: - GameCommand Struct
struct GameCommand: Codable {
    var command: GameCommandType
    var intData: Int? = nil
    var stringData: String? = nil
    var boolData: Bool? = nil
    
    init(_ command: GameCommandType, intData: Int? = nil, stringData: String? = nil, boolData: Bool? = nil) {
        self.command = command
        self.intData = intData
        self.stringData = stringData
        self.boolData = boolData
    }
}

// MARK: - SendableGameData Struct
struct SendableGameData: Codable {
    var type: SendableGameDataType
    var gameCommand: GameCommand?
    var gameState: GameState?
    var sender_PID: Int
}

// MARK: - ConnectivityType Enum
enum ConnectivityType {
    case host, guest, unknown
}

// MARK: - PlayingCard Struct
struct PlayingCard {
    var text: String
    var icon: String = ""
    var indexNum: Int = 30
}

// MARK: - Player Struct
struct Player: Codable {
    var name: String = "PLACEHOLDER_NAME"
    var point: Int = 0
    var cardPos: Int = 1
    var playingCards_CID: [Int] = []
    var color: CodableColor = CodableColor(color: .red)
    
    var backgroundImage: String {
        // Ambil `backgroundImage` berdasarkan color
        getBackgroundImage(for: color)
    }
    
    private func getBackgroundImage(for color: CodableColor) -> String {
        return backgroundImageMapping[color] ?? "SingElingDarkGreen"
    }
}

// MARK: - GameState Struct
struct GameState: Codable {
    var availablePlayingCards_CID: [Int] = []
    var isPlaying: Bool = false
    var players: [Player] = []
    var othersCardsHidden = false
    var triggerGuesserCardShift = false
    var readerCard_CID = 0
    var winner_PID: Int? = nil
    var isCorrect: Bool = false
    var guesserName: String = ""
    var announcementGame = true
    var announcementRole = false

    
    // Reader and Guesser Properties
    var reader_PID: Int =  0
    var guesser_PID: Int = 1
    
    var roomColors: [CodableColor] = [.init(color: .white), .init(color: .white), .init(color: .white), .init(color: .white)]
    var roomImages: [String] = ["", "", "", ""]
    
    var roomIdentifiers: [Int] = []
}

struct CodableColor: Codable, Hashable {
    var red: Double
    var green: Double
    var blue: Double
    var opacity: Double
    
    // Initializer dari Color
    init(color: Color) {
        let uiColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        self.red = Double(red)
        self.green = Double(green)
        self.blue = Double(blue)
        self.opacity = Double(alpha)
    }
    
    // Mengubah ke Color
    func toColor() -> Color {
        return Color(red: red, green: green, blue: blue, opacity: opacity)
    }
}

let backgroundImageMapping: [CodableColor: String] = [
    CodableColor(color: .singElingSB50): "Tikar Oren",
    CodableColor(color: .singElingLC50): "Tikar Merah",
    CodableColor(color: .singElingZ50): "Tikar Hijau",
    CodableColor(color: .singElingDSB50): "Tikar Biru"
]

