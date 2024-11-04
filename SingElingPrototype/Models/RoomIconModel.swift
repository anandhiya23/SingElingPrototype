//
//  RoomIconModel.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 04/11/24.
//

import SwiftUI

struct RoomIconModel {
    let color: Color
    let iconName: String
}

let roomIcons: [RoomIconModel] = [
    RoomIconModel(color: .singElingLC10, iconName: "tree"),
    RoomIconModel(color: .singElingLC50, iconName: "flower"),
    RoomIconModel(color: .singElingZ50, iconName: "mask"),
    RoomIconModel(color: .singElingPG50, iconName: "sword"),
    RoomIconModel(color: .singElingDS70, iconName: "chicken"),
    RoomIconModel(color: .singElingDSB70, iconName: "tshirt"),
    RoomIconModel(color: .singElingLC70, iconName: "flag"),
    RoomIconModel(color: .singElingDSB10, iconName: "guitar")
]
