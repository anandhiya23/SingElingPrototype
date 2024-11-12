//
//  OnBoarding.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 11/11/24.
//

import SwiftUI

struct OnBoardingView: View {
    @EnvironmentObject var gameManager: GameManager
    @Binding var curView: Int
    
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
                
                ButtonComponent(width: 220, height: 64, action: {
                    curView = 6
                }, buttonModel: ButtonModel(button: .mauLihat))
                
                .padding()
                
                ConfirmationButtonComponent(width: 205, height: 64, action: {
                    print("Button tapped")
                })
            }
        }
    }
}

#Preview {
    OnBoardingView(curView: .constant(0))
        .environmentObject(GameManager())
}
