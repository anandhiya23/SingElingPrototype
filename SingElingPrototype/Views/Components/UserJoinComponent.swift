//
//  UserJoinComponent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 03/11/24.
//

import SwiftUI

struct UserJoinComponent: View {
    @EnvironmentObject var gameManager: GameManager
    var width: CGFloat
    
    var body: some View {
        VStack {
            LazyVGrid(
                columns: [
                    GridItem(.fixed(width / 2.2), spacing: width * 0.08),
                    GridItem(.fixed(width / 2.2), spacing: width * 0.08)
                ],
                spacing: width * 0.05
            ) {
                ForEach(gameManager.gameState.players, id: \.self) { player in
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.backgroundCream)
                            .frame(width: width / 2.4, height: width * 0.14)
                        Text(player.name)
                            .font(.custom("Skrapbook", size: width * 0.1))
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(.horizontal, width * 0.1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    UserJoinComponent(width: 300)
        .environmentObject(GameManager(username: "Haliza")) 
}

