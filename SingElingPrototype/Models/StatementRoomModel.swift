//
//  StatementRoomModel.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 02/11/24.
//

import Foundation

enum RoomCondition{
    case createRoomCondition
    case joinRoomCondition
    case joinRoomConditionSuccess
    case joinRoomConditionFailed
}

struct RoomConditionModel{
    var text: String
}
