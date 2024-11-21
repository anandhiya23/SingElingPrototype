//
//  RoomComponent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 01/11/24.
//

import SwiftUI

struct RoomComponent: View {
    @EnvironmentObject var gameManager: GameManager
    
    var roomModel: RoomModel
    var width: CGFloat
    
    var body: some View {
        HStack {
            Text(roomModel.text)
                .font(.custom("Skrapbook", size: width * 0.1))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .font(.custom("Skrapbook", size: width * (23 / 222)))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: width * (8 / 222))
                .fill(roomModel.typeRoom == .createRoom ? Color.singElingDSB30 : Color.singElingLC30)
        )
        .overlay(
            RoundedRectangle(cornerRadius: width * (8 / 222))
                .stroke(Color.black, lineWidth: 5)
        )
        .padding(.horizontal)

    }
}
