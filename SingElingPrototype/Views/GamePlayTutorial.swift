//

//  GameViewTutorial.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 12/11/24.

import SwiftUI
import AVFoundation

struct GamePlayTutorial: View {
    //    @EnvironmentObject var gameManager: GameManager
    @State var vw: CGFloat = 0
    @State var vh: CGFloat = 0
    @State private var announcementGame: Bool = false
    let vmode: Int = 1
    @State private var announcementRole: Bool = false  // Manual toggle for testing
    @State private var guesserName: String = "Player1"
    @State private var isCorrect: Bool = true  // Replace with sample correctness state
    @State private var triggerGuesserCardShift: Bool = false
    @State private var animationCompleted: Bool = false
    @State var myPID: Int = -1
    @State private var buttonColor: Color = .blue
    
    //    @State private var isTextAnimated = false
    @State private var isCardAnimated = false
    //    @State private var isTextDisappearing: Bool = false
    @State private var isFirstTextAnimated = false
    @State private var isFirstTextDisappearing = false
    @State private var isSecondTextAnimated = false
    @State private var isSecondTextDisappearing = false
    @State private var isArrowLineAnimated = false
    @State private var isArrowLineDisappearing = false
    @State private var isTextArrowLine = false
    @State private var isFirstDropZoneShow = false
    @State private var isSecondDropZoneShow = false
    @State private var isThumbAnimated = false
    @State private var isThumbDisappearing = false
    
    @State private var myCards: [PlayingCard] = [
        PlayingCard(text: "My Card 1", indexNum: 1),
        PlayingCard(text: "My Card 2", indexNum: 2),
        PlayingCard(text: "My Card 3", indexNum: 3)
    ]
    @State private var myCardPos: Int = 1
    @State private var backgroundImageName: String = "Tiker Abu Terang"
    //    @State private var vw: CGFloat = UIScreen.main.bounds.width
    //    @State private var vh: CGFloat = UIScreen.main.bounds.height
    @State private var triggerMyCardShift: Bool = false
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    @State var penebakNewColor: Color = .white
    @State var pembacaNewColor: Color = .white
    
    @State private var guesserCards: [PlayingCard] = [
        PlayingCard(text: "Sample Card 1", indexNum: 1),
        PlayingCard(text: "Sample Card 2", indexNum: 2),
        PlayingCard(text: "Sample Card 3", indexNum: 3)
    ]
    @State private var guesserCardPos: Int = 1
    
    
    func startTimer() {
        // Placeholder for the timer functionality
        print("Timer started")
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
    
    
    @State var hintTapped: Bool = false
    @State var penebakTapped: Bool = false
    @State var pembacaTapped: Bool = false
    
    let playerColor = CodableColor(color: .red)
    let penebakColor = CodableColor(color: .blue)
    let pembacaColor = CodableColor(color: .green)
    
    let backgroundImageMapping: [CodableColor: String] = [
        CodableColor(color: .singElingSB50): "Tikar Oren",
        CodableColor(color: .singElingLC50): "Tikar Merah",
        CodableColor(color: .singElingZ50): "Tikar Hijau",
        CodableColor(color: .singElingDSB50): "Tikar Biru",
        //        CodableColor(color: .blue): "Tikar Abu",
        //        CodableColor(color: .green): "Tikar Abu"
    ]
    var penebakBackground: String {
        backgroundImageMapping[penebakColor] ?? "SingElingDarkGreen"
    }
    
    var pembacaBackground: String {
        backgroundImageMapping[pembacaColor] ?? "SingElingDarkGreen"
    }
    
    var playerBackground: String {
        backgroundImageMapping[playerColor] ?? "SingElingDarkGreen"
    }
    
    var body: some View {
        GeometryReader { geom in
            ZStack {
                let imageFrame = geom.size.width * 2
                let imageHeight = geom.size.height * 0.32
                let yPos = announcementGame ? 0.10 * vh : 0.15 * vh
                let targetPositionY = yPos * 2.6
                
                Image("Tiker Abu Gelap")
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageFrame, height: imageHeight)
                    .clipped()
                    .position(x: 0.5 * vw, y: yPos)
                
                VStack{
                    
                    Image("CardLandscape")
                        .resizable()
                        .frame(width: 290, height: 100)
                        .position(x: 0.55 * vw, y: yPos * 1.5) // Posisi target akhir
                        .offset(y: isCardAnimated ? 0 : -UIScreen.main.bounds.height) // Muncul dari atas layar
                        .transition(.opacity) // Efek transisi opacity saat gambar muncul
                        .animation(.easeOut(duration: 1.0), value: isCardAnimated)
                    
                }.onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeOut(duration: 1.0)) {
                            isCardAnimated = true
                        }
                    }
                }
                
                
                ZStack {
                    ZStack {
                        if vmode == 1 {
                            Image(pembacaBackground)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 1.2 * vw, height: vh)
                                .ignoresSafeArea()
                        } else {
                            Image(penebakBackground)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 1.2 * vw, height: vh)
                                .ignoresSafeArea()
                        }
                    }
                    .frame(width: vw, height: vh)
                    
                    
                    
                    Image(playerBackground)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 1.2 * vw, height: vh)
                        .position(x: vw / 2, y: announcementGame ? 0.55 * vh : 0.93 * vh)
                        .shadow(color: .black, radius: 40)
                        .animation(.bouncy.speed(1.4), value: announcementGame)
                        .ignoresSafeArea()
                }
                .frame(width: vw, height: vh)
                
                
                
                // Statement component
                StatementComponent(width: 300, statementRole: StatementRole(userRole: .pembacaView))
                    .position(x: vw / 2, y: announcementGame ? 0.4 * vh : -145 * vh)
                    .animation(.bouncy.speed(1.4), value: announcementGame)
                
                
                // Other cards
                //                RoundedRectangle(cornerRadius: 15)
                //                    .strokeBorder(Color.black.opacity(0.5), style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [10, 13]))
                //                    .frame(width: 20, height: 206)
                //                    .foregroundColor(.red)
                //                    .position(x: vw / 2, y: announcementGame ? -145 : (vmode == 1 ? -145 : 0.26 * vh))
                //                    .animation(.bouncy.speed(1.4), value: announcementGame)
                
                //                ZStack {
                //                    HStack(spacing: 16) {
                //                        ForEach(0..<guesserCards.count, id: \.self) { curCardIdIndice in
                //                            let tempCard = guesserCards[curCardIdIndice]
                //                            CardComponent(width: 119, text: tempCard.text, indexNum: tempCard.indexNum)
                //                                .padding(.leading, curCardIdIndice == guesserCardPos ? 20 : (curCardIdIndice == guesserCardPos + 1 ? 10 : -50))
                //                        }
                //                    }
                //                    .padding(.leading, (vw / 2) - CGFloat(guesserCardPos * 85))
                //                    .frame(width: vw, alignment: .leading)
                //                    .animation(.bouncy.speed(1.4), value: triggerGuesserCardShift)
                //                }
                //                .position(x: vw / 2, y: announcementGame ? -145 : (vmode == 1 ? -145 : 0.26 * vh))
                //                .animation(.bouncy.speed(1.4), value: announcementGame)
                
                // TRIGONAL INDICATOR
                
                //                    .animation(.bouncy.speed(0.5), value: announcementGame)
                
                // Self's cards
                //                                RoundedRectangle(cornerRadius: 15)
                //                                    .strokeBorder(Color.black.opacity(0.5), style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [10, 13]))
                //                                    .frame(width: vmode == 2 ? 0 : 24, height: 244)
                //                                    .foregroundColor(.clear)
                //                                    .position(x: vw / 2, y: announcementGame ? 1.5 * vh : (vmode == 1 ? 0.6 * vh : 1.5 * vh))
                //                                    .animation(.bouncy.speed(0.8), value: announcementGame)
                
                // User's card stack
                //                ZStack {
                //                    HStack(spacing: 16) {
                //                        ForEach(0..<myCards.count, id: \.self) { curCardIdIndice in
                //                            let tempCard = myCards[curCardIdIndice]
                //                            CardComponent(width: 164, text: tempCard.text, indexNum: tempCard.indexNum)
                //                                .padding(.leading, curCardIdIndice == myCardPos ? 20 : (curCardIdIndice == myCardPos + 1 ? 115 : -96))
                //                        }
                //                    }
                //                    .padding(.leading, (vw / 2) - CGFloat(myCardPos * 85))
                //                    .frame(width: vw, alignment: .leading)
                //                    .animation(.bouncy.speed(1.4), value: myCardPos)
                //                    .gesture(
                //                        DragGesture()
                //                            .onEnded { gesture in
                //                                if gesture.translation.width > 50 {
                //                                    myCardPos = max(myCardPos - 1, 0)
                //                                } else if gesture.translation.width < -50 {
                //                                    myCardPos = min(myCardPos + 1, myCards.count - 1)
                //                                }
                //                            }
                //                    )
                //                }
                //                .position(x: vw / 2, y: announcementGame ? 1.5 * vh : (vmode == 1 ? 0.6 * vh : 2 * vh))
                //                .animation(.bouncy.speed(0.5), value: announcementGame)
                
                // Background image
                Image(backgroundImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 1.2 * vw, height: vh)
                    .position(x: vw / 2, y: announcementGame ? 0.55 * vh : 0.92 * vh)
                    .shadow(color: .singGray, radius: 40)
                    .animation(.bouncy.speed(1.4), value: announcementGame)
                    .ignoresSafeArea()
                    .onAppear {
                        if announcementGame {
                            print("Announcement Game Active")
                            startTimer()
                        }
                    }
                    .onChange(of: announcementGame) { newValue in
                        if newValue {
                            print("Announcement Game Toggled")
                            startTimer()
                        }
                    }
                
                // Button component
                //                ButtonComponent(width: 164, height: 64, action: {
                //                    print("Guess action triggered")
                //                }, buttonModel: ButtonModel(button: .mauLihat))
                //                .position(x: vw * 0.5, y: announcementGame ? 1.5 * vh : (vmode == 1 ? 0.9 * vh : 1.5 * vh))
                //                .animation(.bouncy.speed(0.5), value: announcementGame)
                
                //                CardComponent(width: 220, text: "Sample Reader Card Text", indexNum: 1)
                //                    .position(x: 1/2 * vw, y: announcementRole ? (vmode == 2 ? midCardY : 2 * vh) : (vmode == 2 ? midCardY : 2 * vh))
                //                    .animation(.bouncy.speed(1.4), value: announcementRole)
                
                if guesserName != "" {
                    if isCorrect {
                        Rectangle()
                            .fill(Color.singElingDS50)
                            .frame(width: vw, height: 62)
                            .position(x: 0.5 * vw, y: announcementRole ? 0.09 * vh : 0.03 * vh)
                            .animation(.bouncy.speed(0.8), value: announcementRole)
                            .overlay(
                                HStack {
                                    Text("\(guesserName) Berhasil Nebak")
                                        .font(.custom("Skrapbook", size: 32))
                                        .position(x: 0.5 * vw, y: announcementRole ? 0.09 * vh : 0.03 * vh)
                                        .foregroundColor(.singElingDS50)
                                }
                            )
                    } else {
                        Rectangle()
                            .fill(Color.singElingDS50)
                            .frame(width: vw, height: 62)
                            .position(x: 0.5 * vw, y: announcementRole ? 0.09 * vh : 0.03 * vh)
                            .animation(.default, value: announcementRole)
                            .overlay(
                                HStack {
                                    Text("\(guesserName) Salah Nebak")
                                        .font(.custom("Skrapbook", size: 32))
                                        .position(x: 0.5 * vw, y: announcementRole ? 0.09 * vh : 0.03 * vh)
                                        .foregroundColor(.singElingDS50)
                                }
                            )
                    }
                }
                
                HintGameComponent(hintModel: HintModel(userRole: .pembacaView, readerName: "bintang"))
                    .frame(width: 180, height: 50)
                    .position(x: hintTapped ? 0.2 * vw : -0.1 * vw, y: 0.18 * vh)
                    .onTapGesture {
                        self.hintTapped.toggle()
                    }
                    .animation(.bouncy.speed(0.6), value: hintTapped)
                
                Rectangle()
                    .fill(Color.white) // Mengatur warna latar belakang sesuai dengan playerColor
                    .frame(width: vw, height: 62) // Mengatur lebar sesuai vw dan tinggi tetap 62
                    .position(x: 0.5 * vw, y: announcementGame ? 0.03 * vh : 0.09 * vh)
                    .animation(.default, value: announcementGame) // Animasi ketika `announcementGame` berubah
                    .overlay(
                        HStack {
                            Text(vmode == 0 ? "Pemantau" : (vmode == 1 ? "Penebak" : "Pembaca")) // Menampilkan teks sesuai nilai `vmode`
                                .font(.custom("Skrapbook", size: 32)) // Menggunakan font kustom
                                .position(x: 0.5*vw, y:announcementGame ? 0.03*vh : 0.09*vh)
                                .foregroundColor(.singElingBlack)
                        }
                        
                    )
                
                
                
                // Final update on `vw` and `vh` from `geom.size`
                    .onChange(of: geom.size) { newValue in
                        vw = newValue.width
                        vh = newValue.height
                    }
                    .onAppear {
                        vw = geom.size.width
                        vh = geom.size.height
                    }
                
                HStack{
                    Dropzone()
                        .offset(x: 0.15 * vw, y: yPos * 1.15)
                        .opacity(isFirstDropZoneShow ? 1 : 0) // Atur visibilitas dengan opacity
                        .animation(.easeInOut(duration: 1.0), value: isFirstDropZoneShow)
                        .onAppear {
                            // Munculkan Dropzone setelah 16 detik
                            DispatchQueue.main.asyncAfter(deadline: .now() + 14) {
                                withAnimation {
                                    isFirstDropZoneShow = true
                                }
                                
                                // Hilangkan Dropzone setelah 2 detik
                                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                    withAnimation {
                                        isFirstDropZoneShow = false
                                    }
                                }
                            }
                        }
                    VStack{
                        Image("CardSample")
                            .resizable()
                            .frame(width: 200, height: 300)
                            .position(x: 0.4 * vw, y: yPos * 4.5) // Posisi target akhir
                            .offset(y: isCardAnimated ? 0 : UIScreen.main.bounds.height) // Muncul dari bawah layar
                        // Efek transisi opacity saat gambar muncul
                            .animation(.easeOut(duration: 1.0), value: isCardAnimated)
                        
                        
                    }.onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.easeOut(duration: 1.0)) {
                                isCardAnimated = true
                            }
                        }
                    }
                    
                }
                .frame(width: vw)
                
                
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.singElingDS30)
                        .frame(width: 298, height: 60)
                    
                    Text("Hai! Yuk Kita Main Tebak-Tebakan!")
                        .font(.custom("Skrapbook", size: 20))
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                    
                    
                }
                .position(x: 0.5 * vw, y: isFirstTextDisappearing ? vh + 100 : (isFirstTextAnimated ? targetPositionY : -100))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        withAnimation(.easeOut(duration: 1.0)) {
                            isFirstTextAnimated = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.easeIn(duration: 1.0)) {
                                isFirstTextDisappearing = true
                            }
                        }
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.singElingDS30)
                        .frame(width: 351, height: 88)
                    
                    Text("Apakah kejadian di atas lebih sopan atau\n tidak sopan daripada kejadian di bawah?")
                        .font(.custom("Skrapbook", size: 20))
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                    
                    
                }
                .position(x: 0.5 * vw, y: isSecondTextDisappearing ? vh + 100 : (isSecondTextAnimated ? targetPositionY : -100))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                        withAnimation(.easeOut(duration: 1.0)) {
                            isSecondTextAnimated = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.easeIn(duration: 1.0)) {
                                isSecondTextDisappearing = true
                            }
                        }
                    }
                }
                
                ZStack{
                    ArrowLineView(isTextArrowLine: $isTextArrowLine)
                }
                .position(x: 0.5 * vw, y: isArrowLineDisappearing ? vh + 100 : (isArrowLineAnimated ? targetPositionY : -100))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
                        withAnimation(.easeOut(duration: 1.0)) {
                            isArrowLineAnimated = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.easeOut(duration: 1.0)) {
                                isTextArrowLine = true
                            }
                        }
                    }
                }
                
                ZStack{
                    
                    Jempol(width: 135, height: 196)
                        .frame(width: 70, height: 60)
//                        .offset(x: isThumbAnimated ? (0.15 * vw - (vw / 2)) : (0.70 * vw - (vw / 2)),
//                                y: isThumbAnimated ? 310 : UIScreen.main.bounds.height)
//                        .animation(.easeOut(duration: 1.0), value: isThumbAnimated)
                        .offset(x: isThumbAnimated ? (0.15 * vw - (vw / 2)) : (0.70 * vw - (vw / 2)),
                                               y: isThumbDisappearing ? vh : (isThumbAnimated ? 310 : UIScreen.main.bounds.height)) // Muncul lalu menghilang ke bawah
                                       .animation(.easeOut(duration: 1.0), value: isThumbAnimated) // Animasi untuk muncul
                                       .animation(.easeIn(duration: 1.0), value: isThumbDisappearing)
                }
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 16) {
                        withAnimation {
                            isThumbAnimated = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                            withAnimation {
                                                isThumbDisappearing = true
                                            }
                                        }
                    }
                }
                
                ZStack{
                    Image("Tiker Abu Terang") // Gambar tambahan yang akan mengisi sisa frame
                    
                        .resizable()
                        .scaledToFill()
                        .frame(width: vw * 2, height: vh * 0.2) // Menyesuaikan gambar dengan sisa ruang
                        .position(x: vw / 2, y: vh * 2)
                        .shadow(color: .singGray, radius: 1, x: 0, y: 1)
                    
                    ButtonComponent(width: 164, height: 64, action: {
                        print("Button tapped")
                    }, buttonModel: ButtonModel(button: .kunci))
                    
                    
                    .position(x: vw / 2, y: vh + 40)
                }
                
                
            }
            .frame(width: vw, height: vh)
            .ignoresSafeArea()
        }
    }
}

struct ArrowLineView: View {
    @Binding var isTextArrowLine : Bool
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 10) {
                HStack(spacing: 0) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.black)
                        .frame(width: 30, height: 30)
                    
                    Rectangle()
                        .fill(Color.black)
                        .frame(height: 3)
                    
                    Image(systemName: "arrow.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.black)
                        .frame(width: 30, height: 30)
                }
                .padding(.horizontal, 0)
                HStack {
                    Text("LEBIH SOPAN")
                        .font(.custom("Skrapbook", size: isTextArrowLine ? 24 : 16))
                        .padding(.leading, 0)
                    
                    Spacer()
                    
                    Text("LEBIH TIDAK SOPAN")
                        .font(.custom("Skrapbook", size: 16))
                        .padding(.trailing, 0)
                }
                .padding(.horizontal, 8)
            }
            .padding()
        }
    }
}

#Preview {
    GamePlayTutorial(penebakNewColor: .singPink)
}
