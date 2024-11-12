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
    @State private var roleTimer: Int = 0
    @State private var timer: Timer?
    @State var guesserName: String = ""
    @State var playerColor: CodableColor = CodableColor(color: .white) // Default value
    @State var backgroundImage: String = "DefaultBackground"
    
    
    func startTimer() {
        resetTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            roleTimer += 1
            if roleTimer == 3{
                gameManager.gameState.announcementGame = false
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
            return 70 / 100 * vh
        }
    }
    
    
    
    var body: some View {
        GeometryReader { geom in
            ZStack{
                //buat announcement
                if gameManager.gameState.announcementGame{
                    let playerColor = gameManager.gameState.players[gameManager.myPID].color
                    
//                    if vmode == 0 {
//                        Color.singElingLC70
//                    }
//                    if vmode == 1 {
//                        Color.singElingZ70
//                    }
//                    if vmode == 2 {
//                        Color.singOrange
//                    }
                    withAnimation(.easeIn){
                        AnnouncementRoleView(
                            vmode: vmode,
                            readerText: gameManager.readerCardText,
                            readerNum: gameManager.readerCardIndexNum,
                            playerColor: playerColor
                        )
                            .onAppear{
                                startTimer()
                            }
                    }
                    
                }else{
//                    if vmode == 0{
//                        Image("Bambu Ijo 1")
//                            .resizable()
//                            .ignoresSafeArea()
//                            .scaledToFill()
//                        
//                        Image("Bambu Merah 1")
//                            .resizable()
//                            .ignoresSafeArea()
//                            .scaledToFill()
//                            .position(x: 1/2*vw, y: vmode == 1 ? 0.8*vh : 0.98*vh)
//                        
//                    }else if vmode == 1{
//                        Image("Bambu Oren")
//                            .resizable()
//                            .ignoresSafeArea()
//                            .scaledToFill()
//                        
//                        Image("Bambu Ijo 1")
//                            .resizable()
//                            .ignoresSafeArea()
//                            .scaledToFill()
//                            .position(x: 1/2*vw, y: vmode == 1 ? 0.8*vh : 0.98*vh)
//                        
//                    } else{
//                        
//                        Image("Bambu Ijo 1")
//                            .resizable()
//                            .ignoresSafeArea()
//                            .scaledToFill()
//                        
//                        Image("Bambu Oren")
//                            .resizable()
//                            .ignoresSafeArea()
//                            .scaledToFill()
//                            .position(x: 1/2*vw, y: 0.92*vh)
//                        
//                    }
//                    Image(backgroundImage)
//                                            .resizable()
//                                            .ignoresSafeArea()
//                                            .scaledToFill()
                    let playerColor = gameManager.gameState.players[gameManager.myPID].color

                    // Mendapatkan nama gambar dari backgroundImageMapping menggunakan CodableColor
                    let backgroundImageName = backgroundImageMapping[playerColor] ?? "SingElingDarkGreen"

                    // Menggunakan gambar sebagai latar belakang berdasarkan backgroundImageMapping
                    Image(backgroundImageName)
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                    
                    //OTHER'S CARDS
                    RoundedRectangle(cornerRadius: 15)
                        .strokeBorder(Color.black.opacity(0.5), style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [10,13]))
                        .frame(width: 20, height: 206)
                        .foregroundColor(.clear)
                        .position(x:vw/2, y: gameManager.gameState.othersCardsHidden || vmode == 1 ? -145 : 26/100*vh)
                    
                    ZStack(){
                        HStack(spacing: 16) {
                            ForEach(0..<gameManager.guesserCards.count, id: \.self) { curCardIdIndice in
                                let curCardId = gameManager.guesserCards[curCardIdIndice]
                                let tempCard: PlayingCard = gameManager.playingCards[curCardId]
                                
                                // Atur padding untuk membuat gap antara kartu terpilih dan kartu setelahnya
                                CardComponent(width: 147, text: tempCard.text, indexNum: tempCard.indexNum, backgroundImage: gameManager.getBackground(for: tempCard.indexNum))
                                    .padding(.leading, curCardIdIndice == gameManager.guesserCardPos ? 20 : (curCardIdIndice == gameManager.guesserCardPos + 1 ? 60 : -80))
                            }
                        }
                        .padding(.leading, (vw/2) - CGFloat(gameManager.guesserCardPos * 85))
                        .frame(width: vw, alignment: .leading)
                        
                    }
                    .position(x:vw/2, y: gameManager.gameState.othersCardsHidden || vmode == 1 ? -145 : 26/100*vh)
                    .animation(.bouncy.speed(1.4), value: gameManager.triggerGuesserCardShift)
                    
                    //TRIANGLE INDICATOR
                    Jempol(width: 135, height: 196)
                        .rotationEffect(Angle(degrees: 180))
                        .frame(width: 70, height: 60)
                        .position(x:vw/1.9, y: gameManager.gameState.othersCardsHidden || vmode == 1 ? -145 : 5/100*vh)
                    
                    
                    
                    //SELF'S CARDS
                    RoundedRectangle(cornerRadius: 15)
                        .strokeBorder(Color.black.opacity(0.5), style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [10,13]))
                        .frame(width: vmode == 2 ? 0 : 24, height: 244)
                        .foregroundColor(.clear)
                        .position(x:vw/2, y: vmode == 1 ? 0.5*vh : 0.7*vh)
                    
                    ZStack {
                        HStack(spacing: 16) {
                            ForEach(0..<gameManager.myCards.count, id: \.self) { curCardIdIndice in
                                let curCardId = gameManager.myCards[curCardIdIndice]
                                let tempCard: PlayingCard = gameManager.playingCards[curCardId]

                                // Atur padding untuk membuat gap antara kartu terpilih dan kartu setelahnya
                                CardComponent(width: vmode == 2 ? 0 : 164, text: tempCard.text, indexNum: tempCard.indexNum, backgroundImage: gameManager.getBackground(for: tempCard.indexNum))
                                    .padding(.leading, curCardIdIndice == gameManager.myCardPos ? 20 : (curCardIdIndice == gameManager.myCardPos + 1 ? 60 : -96))
                            }
                        }
                        .padding(.leading, (vw / 2) - CGFloat(gameManager.myCardPos * 85))
                        .frame(width: vw, alignment: .leading)
                        .gesture(
                            DragGesture()
                                .onEnded { gesture in
                                    if gesture.translation.width > 50 {
                                        gameManager.myCardPosShiftRight()
                                    } else if gesture.translation.width < -50 {
                                        gameManager.myCardPosShiftLeft()
                                    }
                                }
                        )
                    }
                    .position(x: vw / 2, y: vmode == 1 ? 0.5 * vh : 0.7 * vh)
                    .animation(vmode == 0 || vmode == 1 ? .default : .bouncy.speed(1.4), value: gameManager.myCardPos)

                    
                    Jempol(width: 153, height: 222)
                        .frame(width: 70, height: 60)
                        .position(x:vw/2.1, y: vmode == 1 ? 0.73*vh : 2.5*vh)
                        .animation(.default, value: vmode)
                    
//                    ButtonComponent(width: 166, height: 73, text: "Setuju!", imageName: "bi_hand-thumbs-up-fill"){
//                        gameManager.makeGuess()
//                    }
                    ButtonComponent(width: 164, height: 64, action: {
                        gameManager.makeGuess()
                    }, buttonModel: ButtonModel(button: .kunci))
                    
                    .position(x:vw*1/2, y: vmode == 1 ? 0.9*vh : 1.5*vh)
                    
                    
                    Text("\(Image(systemName: "person.fill")) \(gameManager.guesserName)")
                        .font(.title2)
                        .foregroundStyle(.black)
                        .background(.gray)
                        .position(x: 0.5*vw, y: 0.09*vh)
                        .onTapGesture {
                            gameManager.nextTurn()
                        }
                    

                    CardComponent(width: vmode == 2 ? 220 : 0, text: gameManager.readerCardText, indexNum: gameManager.readerCardIndexNum, backgroundImage: gameManager.getBackground(for: gameManager.readerCardIndexNum))

                    
                    //kartu pembaca
                    CardComponent(width: vmode == 2 ? 220 : 0, text: gameManager.readerCardText, indexNum: gameManager.readerCardIndexNum)

                        .position(x:1/2*vw, y: midCardY)
                        .animation(.default, value: vmode)
                    
                }
                
                //notif salah bener
                if gameManager.gameState.guesserName != ""{
                    if gameManager.gameState.isCorrect{
                        Rectangle()
                            .fill(Color.singElingZ70)
                            .frame(width: vw, height: 62)
                            .position(x: 0.5*vw, y:gameManager.gameState.announcementGame ? 0.09*vh : 0.03*vh)
                            .animation(.default, value: gameManager.gameState.announcementGame)
                            .overlay(
                                HStack{
                                    Text("\(gameManager.guesserName) Berhasil Nebak")
                                        .font(.custom("Skrapbook", size: 32))
                                        .position(x: 0.5*vw, y:gameManager.gameState.announcementGame ? 0.09*vh : 0.03*vh)
                                        .foregroundColor(.white)
                                }
                            )
                    }else{
                        Rectangle()
                            .fill(Color.singElingLC90)
                            .frame(width: vw, height: 62)
                            .position(x: 0.5*vw, y:gameManager.gameState.announcementGame ? 0.09*vh : 0.03*vh)
                            .animation(.default, value: gameManager.gameState.announcementGame)
                            .overlay(
                                HStack{
                                    Text("\(gameManager.guesserName) Salah Nebak")
                                        .font(.custom("Skrapbook", size: 32))
                                        .position(x: 0.5*vw, y:gameManager.gameState.announcementGame ? 0.09*vh : 0.03*vh)
                                        .foregroundColor(.white)
                                }
                            )
                        
                        
                    }
                    
                }
                
                
                //header
                Rectangle()
                    .fill(Color.singElingDS50)
                    .frame(width: vw, height: 62)
                    .position(x: 0.5*vw, y:0.03*vh)
                
                //UI winner
                if gameManager.gameState.winner_PID != nil{
                    ZStack {
                        // Latar belakang hijau, atau gunakan warna lain sesuai desain
                        Color.singKrim
                            .ignoresSafeArea()
                        
                        VStack {
                            // Teks selamat dan nama pemenang
                            Text("Selamat kepada")
                                .font(.headline)
                                .foregroundColor(Color.singElingBlack)
                            
                            Text(gameManager.winnerName)
                                .bold()
                                .font(.title)
                                .foregroundColor(Color.singElingBlack)
                            
                            Text("5/5 Kartu")
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
                                        .fill(Color.singElingBlack)
                                }
                            }
                            
                            Spacer().frame(height: 20)
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
            .ignoresSafeArea()
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
//        .environmentObject(GameManager(username: "Azu"))
//}

