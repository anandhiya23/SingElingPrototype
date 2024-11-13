//
//  MainView.swift
//  SingElingPrototype
//
//  Created by Bintang Anandhiya on 17/10/24.
//

import Foundation
import SwiftUI

struct MainView: View {
    @EnvironmentObject var gameManager: GameManager
    var body: some View {
        switch gameManager.curView{
        case 1:
            ChoiceView()
        case 2:
            HostGenerateRoomView()
        case 3:
            GuestJoinRoomView()
        case 4:
            GameView()
        case 5:
            BintangDragDropView2()
        default:
            ZStack{
                Image("OnBoardingBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                HStack {
                    Spacer()
                    
                    TutorialButtonComponent(width: 170, height: 60) {
                        //                        curView = 6

                    }
                    .padding()
                    .padding(.top, 30)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                
                
                VStack(spacing: 0){
                    Text("Sing Eling")
                        .font(.custom("skrapbook", size: 64))
                        .foregroundColor(Color.singElingRB50)
                        .padding()
                    
                    Text("Yuk, isi nama mu!")
                        .font(.custom("skrapbook", size: 40))
                        .foregroundColor(Color.singElingBlack)
                        .padding()
                    NameInputFormComponent()
                }
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(GameManager())
}

