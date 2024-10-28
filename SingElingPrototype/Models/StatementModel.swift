//
//  StatementModel.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 25/10/24.
//

import Foundation

enum UserRole {
    case pembaca
    case penebak
    case bystander
}

struct StartementModel {
    let text: String
}

struct StatementRole {
    var userRole: UserRole

    var statementText: String {
        switch userRole {
        case .pembaca:
            return "MEMBACA!"
        case .penebak:
            return "MENEBAK!"
        case .bystander:
            return "MEMANTAU!"
        }
    }
}
