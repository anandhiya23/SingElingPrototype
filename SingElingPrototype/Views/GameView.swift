
//
//  ContentView.swift
//  SingElingPrototype
//
//  Created by Bintang Anandhiya on 16/10/24.
//

import SwiftUI
import AVFoundation

struct GameView: View {
    @EnvironmentObject var gameManager: GameManager
    @State var vw: CGFloat = 0
    @State var vh: CGFloat = 0
    @State private var animationCompleted: Bool = false
    @State private var showLeaveConfirmation = false
    @State var myPID: Int = -1
    @State var playConfetti: Bool = false
    @State private var roleTimer: Int = 0
    @State private var timer: Timer?
    @State var guesserName: String = ""
    
    @State var kunciJawaban: Bool = false
    
    @State var penebakNewColor: Color = .white
    @State var pembacaNewColor: Color = .white
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            roleTimer += 1
            print(roleTimer)
            if roleTimer == 1{
                hintTapped = false
                penebakTapped = false
                pembacaTapped = false
                gameManager.gameState.announcementRole = true
                
            }
            if gameManager.gameState.winner_PID == nil{
                if roleTimer == 2{
                    playAnnounceSound()
                    // Play haptic feedback for 2 seconds (repeated every 0.1 seconds)
                    let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
                    feedbackGenerator.prepare()
                    
                    // Trigger the haptic feedback repeatedly every 0.1 seconds for 2 seconds
                    let duration: TimeInterval = 1.0
                    let interval: TimeInterval = 0.01
                    let hapticTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
                        feedbackGenerator.impactOccurred()
                    }
                    
                    // Stop the haptic feedback after 2 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        hapticTimer.invalidate() // Stop the haptic feedback
                    }
                }
            }
            if roleTimer == 3{
                hintTapped = true
                penebakTapped = true
                pembacaTapped = true
                
                penebakNewColor = gameManager.gameState.players[gameManager.gameState.guesser_PID].color.toColor()
                pembacaNewColor = gameManager.gameState.players[gameManager.gameState.reader_PID].color.toColor()
            }
            if roleTimer == 7{
                hintTapped = false
                penebakTapped = false
                pembacaTapped = false
                
                gameManager.gameState.announcementRole = false
            }
            if roleTimer == 8{
                gameManager.gameState.announcementGame = false
            }
            if roleTimer == 9{
                guesserName = gameManager.guesserName
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
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var hintTapped: Bool = false
    @State var penebakTapped: Bool = false
    @State var pembacaTapped: Bool = false
    
    
    var body: some View {
        let playerColor = gameManager.gameState.players[gameManager.myPID].color
        let penebakColor = gameManager.gameState.players[gameManager.gameState.guesser_PID].color
        let pembacaColor = gameManager.gameState.players[gameManager.gameState.reader_PID].color
        let penebakBackground = backgroundImageMapping[penebakColor] ?? "SingElingDarkGreen"
        let pembacaBackground = backgroundImageMapping[pembacaColor] ?? "SingElingDarkGreen"
        let backgroundImageName = backgroundImageMapping[playerColor] ?? "SingElingDarkGreen"
        
        GeometryReader { geom in
            ZStack{
                ZStack{
                    ZStack{
                        if vmode == 1{
                            Image(pembacaBackground)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 1.2*vw, height: vh)
                                .ignoresSafeArea()
                        }else{
                            Image(penebakBackground)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 1.2*vw, height: vh)
                                .ignoresSafeArea()
                        }
                    }
                    .frame(width: vw, height: vh)
                    
                    
                    Image(backgroundImageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 1.2*vw, height: vh)
                        .position(x: vw/2, y: gameManager.gameState.announcementGame ? 0.55*vh : 0.93*vh)
                        .shadow(color: .black,radius: 40)
                        .animation(.bouncy.speed(1.4), value: gameManager.gameState.announcementGame)
                        .ignoresSafeArea()
                        .onAppear{
                            if gameManager.gameState.announcementGame {
                                print(gameManager.gameState.announcementGame)
                                startTimer()
                            }
                        }
                        .onChange(of: gameManager.gameState.announcementGame == true) { oldValue, newValue in
                            if newValue == true {
                                print(newValue)
                                startTimer()
                            }
                        }
                }
                .frame(width: vw, height: vh)
                
                StatementComponent(width: 300, statementRole: StatementRole(userRole: vmode == 0 ? .bystanderView: (vmode == 1 ? .penebakView : .pembacaView)))
                    .position(x:vw/2, y: gameManager.gameState.announcementRole ? 0.4*vh : -145)
                    .animation(.bouncy.speed(1.5), value: gameManager.gameState.announcementRole)
                
                //OTHER'S CARDS
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(Color.black.opacity(0.5), style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [10,13]))
                    .frame(width: 20, height: 206)
                    .foregroundColor(.clear)
                    .position(x:vw/2, y: gameManager.gameState.announcementGame ? -145 : (vmode == 1 ? -145 : 26/100*vh))
                    .animation(.bouncy.speed(1.4), value: gameManager.gameState.announcementGame)
                
                ZStack(){
                    HStack(spacing: 16) {
                        ForEach(0..<gameManager.guesserCards.count, id: \.self) { curCardIdIndice in
                            let curCardId = gameManager.guesserCards[curCardIdIndice]
                            let tempCard: PlayingCard = gameManager.playingCards[curCardId]
                            // Atur padding untuk membuat gap antara kartu terpilih dan kartu setelahnya
                            CardComponent(width: 119, text: tempCard.text, indexNum: tempCard.indexNum, backgroundImage: tempCard.backgroundCard)

                                .padding(.leading, curCardIdIndice == gameManager.guesserCardPos ? 20 : (curCardIdIndice == gameManager.guesserCardPos + 1 ? 10 : -50))
                        }
                    }
                    .padding(.leading, (vw/2) - CGFloat(gameManager.guesserCardPos * 85))
                    .frame(width: vw, alignment: .leading)
                    .animation(.bouncy.speed(1.4), value: gameManager.triggerGuesserCardShift)
                    
                }
                .position(x:vw/2, y: gameManager.gameState.announcementGame ? -145 : (vmode == 1 ? -145 : 26/100*vh))
                .animation(.bouncy.speed(1.4), value: gameManager.gameState.announcementGame)
                
                Jempol(width: 135, height: 196)
                    .rotationEffect(Angle(degrees: 180))
                    .frame(width: 70, height: 60)
                    .position(x:vw/1.9, y: gameManager.gameState.announcementGame ? -145 : (vmode == 1 ? -145 : 8/100*vh))
                    .animation(.bouncy.speed(0.5), value: gameManager.gameState.announcementGame)
                //OTHER'S CARDS

                
                
                
                //SELF'S CARDS
                ZStack {
                    Image("Tangan_pemantau")
                        .resizable()
                        .scaledToFill()
                        .position(x: 1/2*vw, y: gameManager.gameState.announcementGame ? 1.55*vh : (vmode == 0 ? 0.54*vh : 1.55*vh))
                        .frame(height: 0.55*vh)
                        .animation(.bouncy.speed(0.5), value: gameManager.gameState.announcementGame)

                }
                .frame(width: vw, height: vh)
                
                ZStack {
                    Image("Tangan_pembaca")
                        .resizable()
                        .scaledToFill()
                        .position(x: 1/2*vw, y: gameManager.gameState.announcementGame ? 1.55*vh : (vmode == 2 ? 0.4*vh :1.55*vh))
                        .frame(height: 0.3*vh)
                        .animation(.bouncy.speed(0.5), value: gameManager.gameState.announcementGame)

                }
                .frame(width: vw, height: vh)
                
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(Color.black.opacity(0.5), style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [10,13]))
                    .frame(width: vmode == 2 ? 0 : 24, height: 244)
                    .foregroundColor(.clear)
                    .position(x:vw/2, y: gameManager.gameState.announcementGame ? 1.5*vh : (vmode == 1 ? 0.6*vh : 1.5*vh))
                    .animation(.bouncy.speed(0.8), value: gameManager.gameState.announcementGame)
                
                ZStack {
                    HStack(spacing: 16) {
                        ForEach(0..<gameManager.myCards.count, id: \.self) { curCardIdIndice in
                            let curCardId = gameManager.myCards[curCardIdIndice]
                            let tempCard: PlayingCard = gameManager.playingCards[curCardId]
                            // Atur padding untuk membuat gap antara kartu terpilih dan kartu setelahnya
                            CardComponent(width: 164, text: tempCard.text, indexNum: tempCard.indexNum, backgroundImage: tempCard.backgroundCard)
                                .padding(.leading, curCardIdIndice == gameManager.myCardPos ? 20 : (curCardIdIndice == gameManager.myCardPos + 1 ? 115 : -96))
                        }
                    }
                    .padding(.leading, (vw / 2) - CGFloat(gameManager.myCardPos * 85))
                    .frame(width: vw, alignment: .leading)
                    .animation(.bouncy.speed(1.4), value: gameManager.myCardPos)
                    .gesture(
                        DragGesture()
                            .onEnded { gesture in
                                if gesture.translation.width > 50 {
                                    gameManager.myCardPosShiftRight()
                                    kunciJawaban = false
                                } else if gesture.translation.width < -50 {
                                    gameManager.myCardPosShiftLeft()
                                    kunciJawaban = false
                                }
                            }
                    )
                }
                .position(x: vw / 2, y: gameManager.gameState.announcementGame ? 1.5*vh : (vmode == 1 ? 0.6 * vh : 2 * vh))
                .animation(.bouncy.speed(0.5), value: gameManager.gameState.announcementGame)
                
                ZStack {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(0..<gameManager.myCards.count, id: \.self) { curCardIdIndice in
                            let curCardId = gameManager.myCards[curCardIdIndice]
                            let tempCard: PlayingCard = gameManager.playingCards[curCardId]
                            
                            // Atur padding untuk membuat gap antara kartu terpilih dan kartu setelahnya
                            CardComponent(width: 133, text: tempCard.text, indexNum: tempCard.indexNum, backgroundImage: tempCard.backgroundCard)
                        }
                    }
                }
                .position(x: 0.5 * vw, y: gameManager.gameState.announcementGame ? 1.5*vh : (vmode == 0 ? 0.7 * vh : 2 * vh))
                .animation(.bouncy.speed(0.5), value: gameManager.gameState.announcementGame)
                
                Jempol(width: 153, height: 222)
                    .frame(width: 70, height: 60)
                    .position(x:vw/2.1, y: gameManager.gameState.announcementGame ? 1.5*vh : (vmode == 1 ? 0.8*vh : 2.5*vh))
                    .animation(.bouncy.speed(0.5), value: gameManager.gameState.announcementGame)
                //SELF'S CARDS

                
                
                ZStack{
                    Image(backgroundImageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 1.2*vw, height: vh)
                        .position(x: vw/2, y: gameManager.gameState.announcementGame ? 2*vh : (vmode == 1 ? 1.41*vh : 2*vh))
                        .shadow(color: .black,radius: 30)
                        .animation(.bouncy.speed(1.4), value: gameManager.gameState.announcementGame)
                        .ignoresSafeArea()
                }
                
                
                ButtonComponent(buttonModel: ButtonModel(button: kunciJawaban ? .taruh : .kunci), width: 164, height: 64, isButtonEnabled: .constant(true)){
                    if kunciJawaban{
                        gameManager.makeGuess()
                    }else{
                        kunciJawaban = true
                    }
                }
                .position(x:vw*1/2, y: gameManager.gameState.announcementGame ? 1.5*vh : (vmode == 1 ? 0.92*vh : 1.5*vh))
                .animation(.bouncy.speed(0.5), value: gameManager.gameState.announcementGame)
                
                CardComponent(width: 220, text: gameManager.readerCardText, indexNum: gameManager.readerCardIndexNum, backgroundImage: gameManager.readerCardBackground)
                    .position(x:1/2*vw, y: gameManager.gameState.announcementRole ? (vmode == 2 ? midCardY : 2*vh) : (vmode == 2 ? midCardY : 2*vh))
                    .animation(.bouncy.speed(1.4), value: gameManager.gameState.announcementRole)
                
                if guesserName != ""{
                    if gameManager.gameState.isCorrect{
                        Rectangle()
                            .fill(Color.singElingZ70)
                            .frame(width: vw, height: 62)
                            .position(x: 0.5*vw, y:gameManager.gameState.announcementRole ? 0.09*vh : 0.03*vh)
                            .animation(.bouncy.speed(0.8), value: gameManager.gameState.announcementRole)
                            .overlay(
                                HStack{
                                    Text("\(guesserName) Berhasil Nebak")
                                        .font(.custom("Skrapbook", size: 32))
                                        .position(x: 0.5*vw, y:gameManager.gameState.announcementRole ? 0.09*vh : 0.03*vh)
                                        .foregroundColor(.white)
                                }
                            )
                    }else{
                        Rectangle()
                            .fill(Color.singElingLC90)
                            .frame(width: vw, height: 62)
                            .position(x: 0.5*vw, y:gameManager.gameState.announcementRole ? 0.09*vh : 0.03*vh)
                            .animation(.default, value: gameManager.gameState.announcementRole)
                            .overlay(
                                HStack{
                                    Text("\(guesserName) Salah Nebak")
                                        .font(.custom("Skrapbook", size: 32))
                                        .position(x: 0.5*vw, y:gameManager.gameState.announcementRole ? 0.09*vh : 0.03*vh)
                                        .foregroundColor(.white)
                                }
                            )
                        
                        
                    }
                }
                Rectangle()
                    .fill(playerColor.toColor())
                    .frame(width: vw, height: 62)
                    .position(x: 0.5*vw, y:gameManager.gameState.announcementGame ? 0.03*vh : 0.09*vh)
                    .animation(.default, value: gameManager.gameState.announcementGame)
                    .overlay(
                        HStack{
                            Text(vmode == 0 ?  "pemantau" : (vmode == 1 ? "penebak" : "pembaca"))
                                .font(.custom("Skrapbook", size: 32))
                                .position(x: 0.5*vw, y:gameManager.gameState.announcementGame ? 0.03*vh : 0.09*vh)
                                .foregroundColor(.white)
                        }
                    )
                    .onTapGesture {
                        gameManager.nextTurn()
                    }
                
                
                HintGameComponent(hintModel: HintModel(userRole: vmode == 0 ? .bystanderView : (vmode == 1 ? .penebakView : .pembacaView), readerName: "\(gameManager.gameState.players[gameManager.gameState.guesser_PID].name)"))
                    .frame(width: 180, height: 50)
                    .position(x: hintTapped ? 0.2 * vw : -0.1 * vw, y: 0.5 * vh)
                    .onTapGesture {
                        self.hintTapped.toggle()
                    }
                    .animation(.bouncy.speed(0.6), value: hintTapped)
                
                TurnDetailComponent(guesserName: vmode == 1 ? gameManager.gameState.players[gameManager.gameState
                    .reader_PID].name : gameManager.gameState.players[gameManager.gameState
                        .guesser_PID].name, imageName: vmode == 1 ? "fluent-emoji_speaking-head" :"Vector", newColor: vmode == 1 ? pembacaNewColor : penebakNewColor, changeColor: gameManager.gameState.announcementRole)
                .frame(width: 140, height: 40)
                .position(x: penebakTapped ? 0.9 * vw : 1.08 * vw, y: 0.18*vh)
                .onTapGesture {
                    self.penebakTapped.toggle()
                }
                .animation(.bouncy.speed(0.6), value: penebakTapped)
                
                Rectangle()
                    .fill(Color.singElingDS50)
                    .frame(width: vw, height: 62)
                    .position(x: 0.5*vw, y:0.03*vh)
                    .overlay{
                        HStack{
                            BackButtonComponent()
                                .padding()
                                .onTapGesture {
                                    showLeaveConfirmation = true
                                }
                            
                            Spacer()
                            
                            LeadingScoreComponent(players: gameManager.gameState.players)
                                .padding()
                            
                        }
                        .frame(width: 0.9 * vw, height: 62)
                        .position(x: 0.5*vw, y:0.03*vh)
                    }
                
                if showLeaveConfirmation {
                    LeaveConfirmationView(vw: vw, vh: vh,
                        onConfirm: {
                            showLeaveConfirmation = false
                            gameManager.session.disconnect()
                            gameManager.curView = 1
                        },
                        onCancel: {
                            showLeaveConfirmation = false
                        }
                    )
                    .frame(width: vw, height: vh)
                }
                
                
                
                ZStack {
                    Image(backgroundImageMapping[gameManager.gameState.players[gameManager.gameState.winner_PID ?? 0].color] ?? "SingElingDarkGreen")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 1.2*vw, height: vh)
                        .position(x: vw/2, y: gameManager.gameState.winner_PID != nil ? 0.5*vh : 2*vh)
                        .animation(.bouncy.speed(0.5), value: gameManager.gameState.winner_PID)
                        .ignoresSafeArea()
                    
                    VStack {
                        Spacer()
                        ZStack{
                            AnnouncementJuaraComponent(playerColor: gameManager.gameState.players[gameManager.gameState.winner_PID ?? 0].color.toColor(), playerName: gameManager.winnerName)
                                .frame(width: 270, height: 128)
                                .position(x:vw/2.15, y: gameManager.gameState.winner_PID != nil ? 26/100*vh : -145)
                                .animation(.bouncy.speed(0.8), value: gameManager.gameState.winner_PID)
                            
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
                        Spacer()
                        
                        VStack{
                            
                            ButtonComponent(buttonModel: ButtonModel(button: .menuUtama), width: 200, height: 64, isButtonEnabled: .constant(true)){
                                gameManager.session.disconnect()
                                gameManager.curView = 1
                            }
                            .padding()
                            .opacity(gameManager.gameState.winner_PID != nil ? 1 : 0)
                            .animation(.bouncy.speed(0.8), value: gameManager.gameState.winner_PID)
                            
                            
                            // Tombol hanya untuk host
                            if gameManager.isHost {
                                ButtonComponent(buttonModel: ButtonModel(button: .mainLagi), width: 200, height: 64, isButtonEnabled: .constant(true)){
                                    gameManager.startGame()
                                }
                                .padding()
                                .opacity(gameManager.gameState.winner_PID != nil ? 1 : 0)
                                .animation(.bouncy.speed(0.8), value: gameManager.gameState.winner_PID)
                                
                            }
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .frame(width: vw, height: vh)
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

//#Preview {
//    GameView()
//        .environmentObject(GameManager(username: "Azu"))
//}
