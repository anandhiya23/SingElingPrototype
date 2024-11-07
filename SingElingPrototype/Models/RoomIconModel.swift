//
//  RoomIconModel.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 04/11/24.
//

import SwiftUI

struct RoomIconModel: Codable {
    let color: CodableColor
    let iconID: Int
    
    var iconName: String {
        return IconIdentifier(rawValue: iconID)?.iconName() ?? "defaultIcon"
    }
}

enum IconIdentifier: Int, Codable {
    case tree = 1
    case flower = 2
    case mask = 3
    case sword = 4
    case chicken = 5
    case tshirt = 6
    case flag = 7
    case guitar = 8
    
    // Fungsi untuk mendapatkan nama icon berdasarkan identifier
    func iconName() -> String {
        switch self {
        case .tree:
            return "tree"
        case .flower:
            return "flower"
        case .mask:
            return "mask"
        case .sword:
            return "sword"
        case .chicken:
            return "chicken"
        case .tshirt:
            return "tshirt"
        case .flag:
            return "flag"
        case .guitar:
            return "guitar"
        }
    }
}


let roomIcons: [RoomIconModel] = [
    RoomIconModel(color: CodableColor(color: .singElingLC10), iconID: IconIdentifier.tree.rawValue),
    RoomIconModel(color: CodableColor(color: .singElingLC50), iconID: IconIdentifier.flower.rawValue),
    RoomIconModel(color: CodableColor(color: .singElingZ50), iconID: IconIdentifier.mask.rawValue),
    RoomIconModel(color: CodableColor(color: .singElingPG50), iconID: IconIdentifier.sword.rawValue),
    RoomIconModel(color: CodableColor(color: .singElingDS70), iconID: IconIdentifier.chicken.rawValue),
    RoomIconModel(color: CodableColor(color: .singElingDSB70), iconID: IconIdentifier.tshirt.rawValue),
    RoomIconModel(color: CodableColor(color: .singElingLC70), iconID: IconIdentifier.flag.rawValue),
    RoomIconModel(color: CodableColor(color: .singElingDSB10), iconID: IconIdentifier.guitar.rawValue)
]
