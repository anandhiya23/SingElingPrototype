//
//  WinnerAnnouncementComponent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 10/11/24.
//

import SwiftUI

struct WinnerAnnouncementComponent: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        ZStack {
            HStack {
                Image("Jempol Kanan")
                    .resizable()
                    .frame(width: 50, height: 80)
                    .offset(x: 75)
                    .padding(.top, 50)
                    .foregroundColor(.black)
                
                Spacer()
                
                Image("Jempol Kiri")
                    .resizable()
                    .frame(width: 50, height: 80)
                    .offset(x: -75)
                    .padding(.top, 50)
                    .foregroundColor(.black)
            }
            .zIndex(2)
            
            VStack {
                Text("RAJA JAWANYA")
                    .font(.custom("Skrapbook", size: 28))
                    .foregroundColor(.black)
                    .padding(.bottom, 5)
                
                HStack {
                    
                    Text("ADALAH")
                        .font(.custom("Skrapbook", size: 24))
                        .foregroundColor(.black)
                    ZStack {
                        //ini kalo ada namanya dia udh pas layout nya
                        Text(gameManager.winnerName)
                            .font(.custom("Skrapbook", size: 24))
                            .foregroundColor(Color.singElingBlack)
                            .offset(x: -1, y: -1)
                            .tracking(2)
                        
                        Text(gameManager.winnerName)
                            .font(.custom("Skrapbook", size: 24))
                            .foregroundColor(Color.singElingBlack)
                            .offset(x: 1, y: -1)
                            .tracking(2)
                        
                        Text(gameManager.winnerName)
                            .font(.custom("Skrapbook", size: 24))
                            .foregroundColor(Color.singElingBlack)
                            .offset(x: -1, y: 1)
                            .tracking(2)
                        
                        Text(gameManager.winnerName)
                            .font(.custom("Skrapbook", size: 24))
                            .foregroundColor(Color.singElingBlack)
                            .offset(x: 1, y: 1)
                            .tracking(2)
                        
                        Text(gameManager.winnerName)
                            .font(.custom("Skrapbook", size: 24))
                            .foregroundColor(.singPink)
                            .tracking(2)
                    }
                    Text("!")
                        .font(.custom("Skrapbook", size: 24))
                        .foregroundColor(.black)
                }
                
            }
            
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.singElingYellow)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 4)
                    )
            )
            
            .zIndex(1)
            Image("Crown")
                .offset(y: -70)
                .zIndex(0)
        }
    }
}

#Preview {
    WinnerAnnouncementComponent()
        .environmentObject(GameManager(username: "Haliza"))
}
