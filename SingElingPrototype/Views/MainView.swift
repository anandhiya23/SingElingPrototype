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
    @StateObject  var gamePlayViewModel = GamePlayViewModel()
    
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
        case 6:
            GamePlayTutorial()
        case 7:
            NameInputView()
        default:
            ZStack{
                Image("OnBoardingBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack(alignment: .center){
                    Image("LogoFinal")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                        .padding()
                    
                    Text("Yuk Kita Simak \nDulu tutorialnya!")
                        .font(.custom("skrapbook", size: 40))
                        .foregroundColor(Color.singElingRB50)
                        .multilineTextAlignment(.center)
                    
                    ButtonComponent(
                        buttonModel: ButtonModel(button: .mauLihat),
                        width: 190,
                        height: 64,
                        isButtonEnabled: .constant(true))
                    {
                        gameManager.curView = 6
                    }
                       
                    
                    .padding()
                    
                    ConfirmationButtonComponent(width: 205, height: 64, action: {
                        gameManager.curView = 7
                    })
                }
            }
        }
    }
}

#Preview {
    MainView()
        .environmentObject(GameManager())
}

