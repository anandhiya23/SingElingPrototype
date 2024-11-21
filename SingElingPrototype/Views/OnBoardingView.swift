//
//  OnBoarding.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 11/11/24.
//

import SwiftUI

struct OnBoardingView: View {
    @EnvironmentObject var gameManager: GameManager
    @State var curView: Int = 0
    @StateObject  var gamePlayViewModel = GamePlayViewModel()
    
    var body: some View {
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
                    
                    ButtonComponent(buttonModel: ButtonModel(button: .mauLihat), width: 220, height: 64, isButtonEnabled: $gamePlayViewModel.isButtonEnabled){     
                        curView = 6
                    }
                       
                    
                    .padding()
                    
                    ConfirmationButtonComponent(width: 205, height: 64, action: {
                        print("Button tapped")
                    })
                }
            }
    }
}

#Preview {
    OnBoardingView()
        .environmentObject(GameManager())
}

