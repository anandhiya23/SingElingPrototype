//
//  StatementModel.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 25/10/24.
//

import Foundation

enum UserRole {
    case pembacaView
    case penebakView
    case bystanderView
    case mainView
    case createRoomView
    case joinRoomView
    case randomTurnView
}

struct StatementModel {
    let text: String
}

struct StatementRole {
    var userRole: UserRole

    var statementText: String? {
        switch userRole {
        case .pembacaView:
            return "MEMBACA!"
        case .penebakView:
            return "MENEBAK!"
        case .bystanderView:
            return "MEMANTAU!"
        case .mainView:
            return nil
        case .createRoomView:
            return "Gabung ruang \nbermain temanmu!"
        case .joinRoomView:
            return "Berhasil bergabung ke \nruang bermain!"
        case .randomTurnView:
            return "Atur giliran mainmu yuk!"
        }
    }
}
