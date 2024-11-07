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
        default:
            ZStack{
                Rectangle()
                    .fill(Color.singElingZ50)
                    .ignoresSafeArea()
                
                VStack(spacing: 0){
                    Text("Namamu siapa?")
                        .font(.custom("skrapbook", size: 32))
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

