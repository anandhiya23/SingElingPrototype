//
//  GameModel.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 22/10/24.
//

import Foundation

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
struct Player: Codable, Hashable {
    var name: String = "PLACEHOLDER_NAME"
    var point: Int = 0
    var cardPos: Int = 1
    var playingCards_CID: [Int] = []
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
    
    // Reader and Guesser Properties
    var reader_PID: Int =  0
    var guesser_PID: Int = 1
}
