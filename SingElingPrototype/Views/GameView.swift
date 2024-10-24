//
//  ContentView.swift
//  SingElingPrototype
//
//  Created by Bintang Anandhiya on 16/10/24.
//

import SwiftUI
import AVFoundation

struct GameView: View {
//    @EnvironmentObject var gameManager: GameManager
//    @State var vw: CGFloat = 0
//    @State var vh: CGFloat = 0
//    @Published var myPID: Int = -1
//    @State private var audioPlayer: AVAudioPlayer?
//    @Published var gameState: GameState = GameState()
//    @State private var animationCompleted: Bool = false
//    @Published var isCurrentUserWinner: Bool = false
    @EnvironmentObject var gameManager: GameManager
    @State var vw: CGFloat = 0
    @State var vh: CGFloat = 0
    @State private var animationCompleted: Bool = false
//    @State var gameState: GameState
    @State var myPID: Int = -1
    @State var playConfetti: Bool = false
    
    var isCurrentUserWinner: Bool {
        return gameManager.gameState.winner_PID == gameManager.myPID
    }
    
    var vmode: Int{
        gameManager.pmode
    }
    
    var midCardY: CGFloat {
        switch vmode {
        case 0:
            return 55 / 100 * vh
        case 1:
            return 33 / 100 * vh
        default:
            return 64 / 100 * vh
        }
    }
    

    
    var body: some View {
        GeometryReader { geom in
            ZStack{
                Color.singKrim
                RoundedRectangle(cornerRadius: 30.0)
                    .fill(Color.singCoklat)
                    .frame(width: vw, height: 1/2*vh)
                    .position(x: 1/2*vw, y:3/4*vh)
                
                //OTHER'S CARDS
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(Color.black.opacity(0.5), style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [10,13]))
                    .frame(width: 170, height: 170*1.35)
                    .foregroundColor(.clear)
                    .position(x:vw/2, y: gameManager.gameState.othersCardsHidden || vmode == 1 ? -145 : 26/100*vh)
                
                ZStack(){
                    HStack(spacing: -85){
                        ForEach(gameManager.guesserCards.indices, id: \.self){ curCardIdIndice in
                            let curCardId = gameManager.guesserCards[curCardIdIndice]
                            let tempCard: PlayingCard = gameManager.playingCards[curCardId]
                            CardView(width: 170, hidden: false, text: tempCard.text, icon: tempCard.icon, indexnum: tempCard.indexNum)
                                .padding(.leading, curCardIdIndice == gameManager.guesserCardPos ? 130 : 0)
                        }
                    }
                    .padding(.leading, (vw/2) - CGFloat(gameManager.guesserCardPos * 85))
                    .frame(width: vw, alignment: .leading)
                    
                }
                .position(x:vw/2, y: gameManager.gameState.othersCardsHidden || vmode == 1 ? -145 : 26/100*vh)
                .animation(.bouncy.speed(1.4), value: gameManager.triggerGuesserCardShift)
                
                //TRIANGLE INDICATOR
                RoundedTriangle(cornerRadius: 8)
                    .fill(Color.black)
                    .frame(width: 70, height: 60)
                    .position(x:vw/2, y: gameManager.gameState.othersCardsHidden || vmode == 1 ? -145 : 37.5/100*vh)
                
                
                
                //SELF'S CARDS
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(Color.black.opacity(0.5), style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [10,13]))
                    .frame(width: 170, height: 170*1.35)
                    .foregroundColor(.clear)
                    .position(x:vw/2, y: vmode == 0 || vmode == 1 ? 83.5/100*vh : 1.5*vh)
                
                ZStack(){
                    HStack(spacing: -85){
                        ForEach(gameManager.myCards.indices, id: \.self){ curCardIdIndice in
                            let curCardId = gameManager.myCards[curCardIdIndice]
                            let tempCard: PlayingCard = gameManager.playingCards[curCardId]
                            CardView(width: 170, hidden: false, text: tempCard.text, icon: tempCard.icon, indexnum: tempCard.indexNum)
                                .padding(.leading, curCardIdIndice == gameManager.myCardPos ? 130 : 0)
                        }
                    }
                    .padding(.leading, (vw/2) - CGFloat(gameManager.myCardPos * 85))
                    .frame(width: vw, alignment: .leading)
                    
                }
                .position(x:vw/2, y: vmode == 0 || vmode == 1 ? 83.5/100*vh : 1.5*vh)
                .animation(.default, value: vmode)
                .animation(.bouncy.speed(1.4), value: gameManager.myCardPos)
                
                RoundedTriangle(cornerRadius: 8)
                    .fill(Color.black)
                    .rotationEffect(Angle(degrees: 180))
                    .frame(width: 70, height: 60)
                    .position(x:vw/2, y: vmode == 1 ? 0.71*vh : 0.55*vh)
                    .animation(.default, value: vmode)
                
                CircleButton(diameter: 60, icon: "arrow.left")
                    .position(x: vmode == 2 ? 0.5*vw : vw*1/7, y: vh*60/100)
                    .simultaneousGesture(TapGesture().onEnded({
                        gameManager.myCardPosShiftLeft()
                    }))
                    .animation(.default, value: vmode)
                CircleButton(diameter: 60, icon: "arrow.right")
                    .position(x: vmode == 2 ? 0.5*vw : vw*6/7, y: vh*60/100)
                    .simultaneousGesture(TapGesture().onEnded({
                        gameManager.myCardPosShiftRight()
                    }))
                    .animation(.default, value: vmode)
                PillButton(width: 150, height: 60, icon: "checkmark")
                    .position(x:vw*1/2, y: vh*60/100)
                    .simultaneousGesture(TapGesture().onEnded({
                        gameManager.makeGuess()
                    }))
                
                if(vmode == 2){
                    Text("Bacakan kepada \(gameManager.guesserName)")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .position(x: 0.5*vw, y: 0.9*vh)
                }
                
                Text("\(Image(systemName: "person.fill")) \(gameManager.guesserName)")
                    .font(.title2)
                    .foregroundStyle(.black)
                    .position(x: 0.5*vw, y: 0.09*vh)
                    .onTapGesture {
                        gameManager.nextTurn()
                    }
                
                
                CardView(width: vmode == 0 ? 170 : 270, hidden: !gameManager.isReader, text: gameManager.readerCardText, indexnum: gameManager.readerCardIndexNum)
                    .position(x:1/2*vw, y: midCardY)
                    .animation(.default, value: vmode)
                
                //                                                if gameManager.gameState.winner_PID != nil{
                //                                                    ZStack{
                //                                                        VStack{
                //                                                            Text("Selamat kepada")
                //                                                            Text(gameManager.winnerName)
                //                                                                .bold()
                //                                                                .font(.title)
                //                                                            Text("8/8 Kartu")
                //                                                            Spacer().frame(height: 20)
                //                                                            if gameManager.isHost{
                //                                                                Button("Main Lagi"){
                //                                                                    gameManager.startGame()
                //                                                                }
                //                                                                .padding()
                //                                                                .foregroundStyle(Color.white)
                //                                                                .background{
                //                                                                    RoundedRectangle(cornerRadius: 10)
                //                                                                        .fill(Color.black)
                //                                                                }
                //                                                            }
                //                                                        }
                //                                                    }
                //                                                    .frame(width: vw, height: vh)
                //                                                    .background(Color.singGreen)
                //                                                }
                if gameManager.gameState.winner_PID != nil{
                    ZStack {
                         // Latar belakang hijau, atau gunakan warna lain sesuai desain
                        Color.singKrim
                             .ignoresSafeArea()
                         
                         VStack {
                             // Teks selamat dan nama pemenang
                             Text("Selamat kepada")
                                 .font(.headline)
                                 .foregroundColor(.black)
                             
                             Text(gameManager.winnerName)
                                 .bold()
                                 .font(.title)
                                 .foregroundColor(.black)
                             
                             Text("8/8 Kartu")
                                 .foregroundColor(.gray)
                             
                             Spacer().frame(height: 20)
                             
                             // Tambahkan ikon trofi
                             Image(systemName: "trophy.fill")
                                 .resizable()
                                 .scaledToFit()
                                 .frame(width: 100, height: 100)
                                 .foregroundColor(.yellow)
                             
                             Spacer().frame(height: 20)
                             
                             // Tombol hanya untuk host
                             if gameManager.isHost {
                                 Button("Main Lagi") {
                                     gameManager.startGame()  // Fungsi reset permainan
                                 }
                                 .padding()
                                 .foregroundColor(.white)
                                 .background {
                                     RoundedRectangle(cornerRadius: 10)
                                         .fill(Color.black)
                                 }
                             }
                             
                             Spacer().frame(height: 20)
                             
                             // Animasi confetti (jika belum selesai)
//                             if animationCompleted {
//                                 AnimationView(name: "congrats-confetti", animationSpeed: 0.5, loopMode: .playOnce)
//                                     .frame(width: 200, height: 200)
//                                     .onAppear {
//                                         playSoundOnce()
//                                     }
//                                     .onDisappear {
//                                         animationCompleted = true
//                                     }
//                             }
//                         }
                             if isCurrentUserWinner {
                                // Mainkan animasi confetti
                                 AnimationView(name: "congrats-confetti", animationSpeed: 0.5, loopMode: .playOnce, play: $playConfetti)
                                     .frame(width: 200, height: 200)
                                     .onChange(of: gameManager.gameState.winner_PID){ oldValue, newValue in
                                         if newValue != nil {
                                             playWinnerSound()
                                             playConfetti.toggle()
                                         }
                                     }
                             }
                         }
                         .padding()
                         .frame(width: vw, height: vh)
                     }

                }
 
                
            }
            .frame(width: vw, height: vh)
            .onChange(of: geom.size) { oldValue, newValue in
                vw = newValue.width
                vh = newValue.height
            }
            .onAppear{
                vw = geom.size.width
                vh = geom.size.height
            }
        }
        .ignoresSafeArea()
    }
}
//                if gameManager.gameState.winner_PID != nil {
//                    ZStack {
//                        // Latar belakang hijau, atau gunakan warna lain sesuai desain
//                        Color.singGreen
//                            .ignoresSafeArea()
//
//                        VStack {
//                            // Teks selamat dan nama pemenang
//                            Text("Selamat kepada")
//                                .font(.headline)
//                                .foregroundColor(.black)
//
//                            Text(gameManager.winnerName)
//                                .bold()
//                                .font(.title)
//                                .foregroundColor(.black)
//
//                            Text("8/8 Kartu")
//                                .foregroundColor(.gray)
//
//                            Spacer().frame(height: 20)
//
//                            // Tambahkan ikon trofi
//                            Image(systemName: "trophy.fill")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 100, height: 100)
//                                .foregroundColor(.yellow)
//
//                            Spacer().frame(height: 20)
//
//                            // Tombol hanya untuk host
//                            if gameManager.isHost {
//                                Button("Main Lagi") {
//                                    gameManager.startGame()  // Fungsi reset permainan
//                                }
//                                .padding()
//                                .foregroundColor(.white)
//                                .background {
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .fill(Color.black)
//                                }
//                            }
//
//                            Spacer().frame(height: 20)
//
//                            // Animasi confetti (jika belum selesai)
//                            if !animationCompleted {
//                                AnimationView(name: "congrats-confetti", animationSpeed: 0.5, loopMode: .playOnce)
//                                    .frame(width: 200, height: 200)
//                                    .onAppear {
//                                        playSoundOnce()
//                                    }
//                                    .onDisappear {
//                                        animationCompleted = true
//                                    }
//                            }
//                        }
//                        .padding()
//                        .frame(width: vw, height: vh)
//                    }
//                    .onChange(of: geom.size) { _, newValue in
//                        vw = newValue.width
//                        vh = newValue.height
//                    }
//                    .onAppear {
//                        vw = geom.size.width
//                        vh = geom.size.height
//                    }
//                }
//            }
//            .ignoresSafeArea()
//        }

//#Preview {
//    GameView()
//}

