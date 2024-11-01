//
//  MainViewHaliza.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 01/11/24.
//
import Foundation
import SwiftUI

struct MainViewHaliza: View {
    @State var gameManager: GameManager?
    @State var curView: Int = 0
    @State var username = ""
    
    var body: some View {
        switch curView {
        case 2:
            GameView()
                .environmentObject(gameManager!)
        case 1:
            PairView(curView: $curView)
                .environmentObject(gameManager!)
        default:
            ZStack{
                Rectangle()
                    .fill(Color.singElingZ50)
                    .ignoresSafeArea()
                
                VStack(spacing: 0){
                    Text("Namamu siapa?")
                        .font(.custom("skrapbook", size: 32))
                        .padding()
                    NameInputFormComponent()
//                        .padding(.top, 0)
                }
//                .frame(maxHeight: .infinity)
            }
        }
    }
}

#Preview {
    MainViewHaliza()
}
