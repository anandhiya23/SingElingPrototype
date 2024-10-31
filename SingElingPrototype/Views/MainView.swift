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
        case 2:
            GameView()
                            .environmentObject(gameManager)
        case 1:
            PairView(curView: $curView)
                            .environmentObject(gameManager)
        default:
            VStack(spacing: 20){
                Spacer()
                
                Image(systemName: "doc.questionmark.fill")
                    .foregroundColor(.black)
                    .font(.system(size: 100))
                
                Text("Sing Eling")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                
                Text("Masukkan nama panggilan di\nbawah ini. Pilih sesuatu yang akan\ndikenalioleh teman-temanmu!")
                    .font(.caption)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
                
                NameInputFormComponent(curView: $curView)
                    .environmentObject(gameManager)
                
                Spacer()
            }
        }
    }
}

#Preview {
    MainView()
}

