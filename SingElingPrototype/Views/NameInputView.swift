//
//  NameInputView.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 21/11/24.
//

import SwiftUI

struct NameInputView: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        
        ZStack{
            Image("OnBoardingBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            HStack {
                Spacer()
                
                TutorialButtonComponent(width: 170, height: 60) {
                    gameManager.curView = 6
            
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

#Preview {
    NameInputView()
        .environmentObject(GameManager())
}
