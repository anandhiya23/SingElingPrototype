//
//  MainView.swift
//  SingElingPrototype
//
//  Created by Bintang Anandhiya on 17/10/24.
//

import Foundation
import SwiftUI

struct MainView: View {
    @State var gameManager: GameManager? //GameManager(username: String(UUID().uuidString.prefix(6)))
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
                
                TextField("Nama Panggilan", text: $username)
                    .padding(.horizontal, 75.0)
                    .padding(.bottom, 24)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Lanjut →") {
                    gameManager = GameManager(username: username)
                    curView = 1
                }.buttonStyle(GrowingButton())
                
                SetujuButton()
                
                Spacer()
            }
        }
    }
}
