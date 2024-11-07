//
//  FailedEnteredRoomView.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 05/11/24.
//

import SwiftUI

struct FailedEnteredRoomView: View {
    @EnvironmentObject var gameManager: GameManager
    @Binding var curView: Int
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.singElingZ50)
                .ignoresSafeArea()
            VStack(spacing: 20){
                StatementRoomComponent(width: 300, roomCondition: .joinRoomConditionFailed)
                    .padding(.top, 100)
                
                Text("ini buat random card")
                    .font(.custom("skrapbook", size: 24))
                    .padding(.top, 50)
                
                Spacer()
                
                Rectangle()
                    .fill(Color.singElingLC50)
//                     .ignoresSafeArea()
                    .frame(height: 130)
                    .overlay(
                       SetujuButton(width: 164, height: 64, text: "Setuju!", imageName: "bi_hand-thumbs-up-fill") {
                           print("Setuju button pressed!") // Debugging
//                           curView = 1
                       }
                    )
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    FailedEnteredRoomView(curView: .constant(0))
        .environmentObject(GameManager(username: "Haliza"))
}
