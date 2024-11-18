//
//  AnnouncementWinnerView.swift
//  SingElingPrototype
//
//  Created by Lazuardhi Imani Ahfar on 15/11/24.
//

import SwiftUI

struct AnnouncementWinnerView: View {
    var winnerName: String = ""
    var isHost: Bool = false
    var winnerColor: Color = .red
    @State var announcementWinner: Bool = false
    @State private var roleTimer: Int = 0
    @State private var timer: Timer?
    
    var action: () -> Void = { }
    
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            roleTimer += 1
            print(roleTimer)
            if roleTimer == 1{
                
            }
            if roleTimer == 2{
            }
            if roleTimer == 3{
            }
            if roleTimer == 7{
            }
            if roleTimer == 8{
            }
            if roleTimer == 9{
                resetTimer()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        stopTimer()
        roleTimer = 0
    }
    
    var body: some View {
        ZStack {
            // Latar belakang hijau, atau gunakan warna lain sesuai desain
            
            VStack {
                Spacer()
                // Teks selamat dan nama pemenang
                AnnouncementJuaraComponent(playerColor: winnerColor, playerName: winnerName)
                    .frame(width: 270, height: 128)
                    .position(x:402/2.15, y: !announcementWinner ? 26/100*874 : -250)
                    .animation(.bouncy.speed(0.5), value: announcementWinner)

                
                Spacer()
                if isHost{
                    ButtonComponent(width: 200, height: 64, action: {
                        print("Button tapped")
                    }, buttonModel: ButtonModel(button: .mainLagi))
                }
                Spacer()
                
                
//                Spacer().frame(height: 20)
                //                if isCurrentUserWinner {
                //                    // Mainkan animasi confetti
                //                    AnimationView(name: "congrats-confetti", animationSpeed: 0.5, loopMode: .playOnce, play: $playConfetti)
                //                        .frame(width: 200, height: 200)
                //                        .onChange(of: gameManager.gameState.winner_PID){ oldValue, newValue in
                //                            if newValue != nil {
                //                                playWinnerSound()
                //                                playConfetti.toggle()
                //                            }
                //                        }
                //                }
            }
            .padding()
            //            .frame(width: vw, height: vh)
        }
//        .onAppear{
//            self.announcementWinner = true
//        }
    }
}

#Preview {
    var announcementWinner: Bool = false

    
    AnnouncementWinnerView(winnerName: "Rayhan", isHost: true, winnerColor: .singElingZ70, announcementWinner: announcementWinner){
        announcementWinner = !announcementWinner
        print(announcementWinner)
    }
}