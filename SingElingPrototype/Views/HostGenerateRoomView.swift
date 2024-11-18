//
//  HostGenerateRoomView.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 04/11/24.
//

import SwiftUI

struct HostGenerateRoomView: View {
    @EnvironmentObject var gameManager: GameManager
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.singElingZ50)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                StatementRoomComponent(width: 300, roomCondition: .createRoomCondition)
                    .padding(.top, 100)

                RandomCodeRoomComponent()
                    .padding(.top, 50)

                HintComponent(hintModel: HintModel(userRole: .createRoomView, readerName: ""), width: 300)
                    .padding(.top, 50)
                
                Spacer()
                
                Rectangle()
                    .fill(Color.singElingLC50)
                    .frame(height: 130)
                    .overlay(
                        ButtonComponent(buttonModel: ButtonModel(button: .lanjut), width: 164, height: 64){
                            gameManager.curView = 5
            
                        }
                    )
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}

#Preview {
    HostGenerateRoomView()
        .environmentObject(GameManager())
}
