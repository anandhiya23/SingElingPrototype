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
    
    @State var temptest = [0,1,2,3,4,5,6,7,8,9]
    @ObservedObject var gameManager = GameManager()

    
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
        
        ScrollView(.horizontal) {
            HStack{
                ForEach(gameManager.playingCards.indices, id: \.self){ curCardIdIndice in
                    CardComponent(
                        width: 200,
                        text: "\(gameManager.playingCards[curCardIdIndice].backgroundCard)",
                        indexNum: gameManager.playingCards[curCardIdIndice].indexNum,
                        backgroundImage: gameManager.playingCards[curCardIdIndice].backgroundCard
                    )
                }
            }
        }
    }
}

#Preview {
    var announcementWinner: Bool = false

    
    AnnouncementWinnerView(winnerName: "Rayhan", isHost: true, winnerColor: .singElingZ70, announcementWinner: announcementWinner){
        announcementWinner = !announcementWinner
        print(announcementWinner)
    }
}
