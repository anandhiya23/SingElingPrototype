//
//  RoomModel.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 01/11/24.
//

import Foundation

enum TypeRoom{
    case createRoom
    case joinRoom
}


struct RoomModel{
    var typeRoom: TypeRoom
    
    var text: String{
        switch typeRoom{
        case .createRoom:
            return "Buat Ruangan"
        case .joinRoom:
            return "Gabung Ruangan"
        }
    }
    
    var imageName: String {
        switch typeRoom {
        case .createRoom:
            return "heroicons-solid_question-mark-circle"
        case .joinRoom:
            return "heroicons-solid_question-mark-circle"
        }
    }
}
