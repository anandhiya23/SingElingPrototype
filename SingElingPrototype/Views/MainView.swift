//
//  MainView.swift
//  SingElingPrototype
//
//  Created by Bintang Anandhiya on 17/10/24.
//

import Foundation
import SwiftUI

struct MainView: View {
    @StateObject private var gameManager = GameManager(username: String(UUID().uuidString.prefix(6))) 
    @State var curView: Int = 0
    
    var body: some View {
        switch curView {
        case 1:
            PairView(curView: $curView)
                            .environmentObject(gameManager)
        case 2:
            GameView()
                            .environmentObject(gameManager)
        case 3:
            PairViewContent(curView: $curView)
                            .environmentObject(gameManager)
        case 4:
            BintangDragDropView2(curView: $curView)
                            .environmentObject(gameManager)
        case 5:
            CountdownView(curView: $curView)
                            .environmentObject(gameManager)
        default:
            ZStack{
                Image("OnBoardingBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                HStack {
                       Spacer()
                       
                    TutorialButtonComponent(width: 170, height: 60) {
                        curView = 6
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
                    NameInputFormComponent(curView: $curView)
                        .environmentObject(gameManager)
                }
            }
        }
    }
}

#Preview {
    MainView()
}

