//

//  GameViewTutorial.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 12/11/24.

import SwiftUI
import AVFoundation

struct GamePlayTutorial: View {
    @StateObject  var gamePlayViewModel = GamePlayViewModel()
    @EnvironmentObject var gameManager: GameManager
    
    @State var vw: CGFloat = 0
    @State var vh: CGFloat = 0
    @State var showImage: Bool = false
    
    @State var isSuccessOverlayVisible = false
    @State var isFailedOverlayVisible = false
    
    var body: some View {
        GeometryReader { geom in
            ZStack {
                let imageFrame = geom.size.width * 2
                let imageHeight = geom.size.height * 0.32
                let yPos = gamePlayViewModel.announcementGame ? 0.10 * vh : 0.15 * vh
                let targetPositionY = yPos * 2.6
                
                Image("Tiker Abu Gelap")
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageFrame, height: imageHeight)
                    .clipped()
                    .position(x: 0.5 * vw, y: yPos)
                
                
                ZStack {
                    ZStack {
                        if gamePlayViewModel.vmode == 1 {
                            Image(gamePlayViewModel.pembacaBackground)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 1.2 * vw, height: vh)
                                .ignoresSafeArea()
                        } else {
                            Image(gamePlayViewModel.penebakBackground)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 1.2 * vw, height: vh)
                                .ignoresSafeArea()
                        }
                    }
                    .frame(width: vw, height: vh)
                    
                    
                    
                    Image(gamePlayViewModel.playerBackground)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 1.2 * vw, height: vh)
                        .position(x: vw / 2, y: gamePlayViewModel.announcementGame ? 0.55 * vh : 0.93 * vh)
                        .shadow(color: .black, radius: 40)
                        .animation(.bouncy.speed(1.4), value: gamePlayViewModel.announcementGame)
                        .ignoresSafeArea()
                }
                .frame(width: vw, height: vh)
                
                
                
                // Statement component
                StatementComponent(width: 300, statementRole: StatementRole(userRole: .pembacaView))
                    .position(x: vw / 2, y: gamePlayViewModel.announcementGame ? 0.4 * vh : -145 * vh)
                    .animation(.bouncy.speed(1.4), value: gamePlayViewModel.announcementGame)
                
                
                // Background image
                Image(gamePlayViewModel.backgroundImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 1.2 * vw, height: vh)
                    .position(x: vw / 2, y: gamePlayViewModel.announcementGame ? 0.55 * vh : 0.92 * vh)
                    .shadow(color: .singGray, radius: 40)
                    .animation(.bouncy.speed(1.4), value: gamePlayViewModel.announcementGame)
                    .ignoresSafeArea()
                    .onAppear {
                        if gamePlayViewModel.announcementGame {
                            print("Announcement Game Active")
                            gamePlayViewModel.startTimer()
                        }
                    }
                    .onChange(of: gamePlayViewModel.announcementGame) { newValue in
                        if newValue {
                            print("Announcement Game Toggled")
                            gamePlayViewModel.startTimer()
                        }
                    }
                
                // Button component
                //                                ButtonComponent(width: 164, height: 64, action: {
                //                                    print("Guess action triggered")
                //                                }, buttonModel: ButtonModel(button: .mauLihat))
                //                                .position(x: gamePlayViewModel.vw * 0.5, y: gamePlayViewModel.announcementGame ? 1.5 * vh : (gamePlayViewModel.vmode == 1 ? 0.9 * vh : 1.5 * vh))
                //                                .animation(.bouncy.speed(0.5), value: gamePlayViewModel.announcementGame)
                
                //                CardComponent(width: 220, text: "Sample Reader Card Text", indexNum: 1)
                //                    .position(x: 1/2 * vw, y: announcementRole ? (vmode == 2 ? midCardY : 2 * vh) : (vmode == 2 ? midCardY : 2 * vh))
                //                    .animation(.bouncy.speed(1.4), value: announcementRole)
                
                if gamePlayViewModel.guesserName != "" {
                    if gamePlayViewModel.isCorrect {
                        Rectangle()
                            .fill(Color.singElingDS50)
                            .frame(width: vw, height: 62)
                            .position(x: 0.5 * vw, y: gamePlayViewModel.announcementRole ? 0.09 * vh : 0.03 * vh)
                            .animation(.bouncy.speed(0.8), value: gamePlayViewModel.announcementRole)
                            .overlay(
                                HStack {
                                    Text("\(gamePlayViewModel.guesserName) Berhasil Nebak")
                                        .font(.custom("Skrapbook", size: 32))
                                        .position(x: 0.5 * vw, y: gamePlayViewModel.announcementRole ? 0.09 * vh : 0.03 * vh)
                                        .foregroundColor(.singElingDS50)
                                }
                            )
                    } else {
                        Rectangle()
                            .fill(Color.singElingDS50)
                            .frame(width: vw, height: 62)
                            .position(x: 0.5 * vw, y: gamePlayViewModel.announcementRole ? 0.09 * vh : 0.03 * vh)
                            .animation(.default, value: gamePlayViewModel.announcementRole)
                            .overlay(
                                HStack {
                                    Text("\(gamePlayViewModel.guesserName) Salah Nebak")
                                        .font(.custom("Skrapbook", size: 32))
                                        .position(x: 0.5 * vw, y: gamePlayViewModel.announcementRole ? 0.09 * vh : 0.03 * vh)
                                        .foregroundColor(.singElingDS50)
                                }
                            )
                    }
                }
                
                
                
                Rectangle()
                    .fill(Color.white) // Mengatur warna latar belakang sesuai dengan playerColor
                    .frame(width: vw, height: 62) // Mengatur lebar sesuai vw dan tinggi tetap 62
                    .position(x: 0.5 * vw, y: gamePlayViewModel.announcementGame ? 0.03 * vh : 0.09 * vh)
                    .animation(.default, value: gamePlayViewModel.announcementGame) // Animasi ketika `announcementGame` berubah
                    .overlay(
                        HStack {
                                                        Text(
                                                            gamePlayViewModel.vmode == 0 ? "Penebak" :
                                                                (gamePlayViewModel.vmode == 1 ? "Anda salah menebak" : "Anda berhasil menebak")
                                                        )
                                .font(.custom("Skrapbook", size: 32)) // Menggunakan font kustom
                                .position(x: 0.5 * vw, y: gamePlayViewModel.announcementGame ? 0.03 * vh : 0.09 * vh)
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
                    
                    if gamePlayViewModel.areTwoCardsVisible{
                        VStack {
                            VStack{
                                Image("Card25-tutorial")
                                    .resizable()
                                    .frame(width: 150, height: 250)
                                    .position(
                                        x: gamePlayViewModel.isBothCardsCentered ? vw / 2 - 90 : 0.5 * vw,
                                        y: yPos * 4.5
                                    )
                                    .zIndex(0)
                                    .offset(y: gamePlayViewModel.isCardAnimated ? 0 : UIScreen.main.bounds.height)
                                    .animation(.easeOut(duration: 1.0), value: gamePlayViewModel.isBothCardsCentered)
                            }
                                                        .onAppear {
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                                withAnimation(.easeOut(duration: 1.0)) {
                                                                    gamePlayViewModel.isCardAnimated = true
                                                                }
                                                            }
                                                        }
                            
                            
                            VStack{
                                Image("Card100-tutorial")
                                    .resizable()
                                    .frame(width: 150, height: 250)
                                    .position(
                                        x: gamePlayViewModel.isCardTwoAnimated ? 290 : 475,
                                        y: gamePlayViewModel.isCardTwoAnimated ? 130 : 130
                                    )
                                    .animation(.easeOut(duration: 1.0), value: gamePlayViewModel.isCardTwoAnimated)
                            }
                        }
                    }
                    
                    
                }
                .frame(width: vw, height: vh)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.singElingDS30)
                        .frame(width: 298, height: 60)
                    
                    Text("Perhatikan angka di bawah kartu")
                        .font(.custom("Skrapbook", size: 20))
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                    
                    
                }
                
                .position(
                    x: 0.5 * vw,
                    y: gamePlayViewModel.isFirstTextDisappearing
                    ? vh + 150
                    : (gamePlayViewModel.isFirstTextAnimated ? targetPositionY : -100)
                )
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                        withAnimation(.easeOut(duration: 1.0)) {
                                            gamePlayViewModel.isFirstTextAnimated = true
                                        }
                                    }
                
                                }
                
                .onChange(of: gamePlayViewModel.isFirstTextAnimated) { animated in
                    if animated {
                        gamePlayViewModel.enableButton()
                    }
                }
                
                
                if gamePlayViewModel.isSecondTextShow {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.singElingDS30)
                            .frame(width: 351, height: 88)
                        
                        Text("Angka tersebut merupakan \nindex ketidaksopanan")
                            .font(.custom("Skrapbook", size: 20))
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                        
                        
                    }
                    .position(x: 0.5 * vw, y: targetPositionY)
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.singElingDS30)
                        .frame(width: 298, height: 60)
                    
                    Text("Semakin tinggi angkanya, \nsemakin tinggi ketidaksopannya!")
                        .font(.custom("Skrapbook", size: 20))
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                    
                    
                }
                
                .position(
                    x: 0.5 * vw,
                    y: gamePlayViewModel.isThirdTextDisappearing
                    ? vh + 150
                    : (gamePlayViewModel.isThirdTextAnimated ? targetPositionY : -100)
                )
                
                .onChange(of: gamePlayViewModel.isThirdTextAnimated) { animated in
                    if animated {
                        gamePlayViewModel.enableButton()
                    }
                }
                
                if gamePlayViewModel.isFourthTextDisappearing != true{
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.singElingDS30)
                            .frame(width: 298, height: 60)
                        
                        Text("Pasti jelas nyeleding guru sudah \npaling tidak sopan!")
                            .font(.custom("Skrapbook", size: 20))
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                        
                        
                    }
                    
                    .position(
                        x: 0.5 * vw,
                        y: gamePlayViewModel.isFourthTextDisappearing
                        ? vh + 150
                        : (gamePlayViewModel.isFourthTextAnimated ? targetPositionY : -100)
                    )
                    
                    .onChange(of: gamePlayViewModel.isFourthTextAnimated) { animated in
                        if animated {
                            gamePlayViewModel.enableButton()
                        }
                    }
                }
                
                if gamePlayViewModel.isNinthStageVisible {
                    VStack{
                        VStack {
                            Image("CardLandscape1")
                                .resizable()
                                .frame(width: 290, height: 100)
                                .position(x: 0.50 * vw, y: yPos * 1.5)
                                .offset(y: gamePlayViewModel.isCardLandscape1 ? 0 : -UIScreen.main.bounds.height)
                                .transition(.opacity)
                                .animation(.easeOut(duration: 1.0), value: gamePlayViewModel.isCardLandscape1)
                        }
                        
                        
                        VStack{
                            Image("Card50-tutorial")
                                .resizable()
                                .frame(width: 150, height: 250)
                                .position(
                                    x: gamePlayViewModel.isCardLeftAnimated
                                    ? 0.26 * vw // Posisi kiri jika isCardLeftAnimated = true
                                    : (gamePlayViewModel.isCardRightAnimated
                                       ? 0.74 * vw // Posisi kanan jika isCardRightAnimated = true
                                       : (gamePlayViewModel.isFirstCenterAnimated
                                          ? 0.26 * vw // Posisi kiri jika isFirstCenterAnimated = true
                                          : (gamePlayViewModel.isSecondCenterAnimated
                                             ? 0.74 * vw // Posisi kanan jika isSecondCenterAnimated = true
                                             : 0.5 * vw // Posisi tengah (default)
                                            )
                                         )
                                      ),
                                    y: gamePlayViewModel.isThirdAnimated ? yPos * 0.4 : yPos * 1.1 //atas bawah
                                )
                            //                            .offset(gamePlayViewModel.dragOffset)
                                .offset(y: gamePlayViewModel.isCardFourthAnimated ? 0 : UIScreen.main.bounds.height)
                                .gesture(
                                    gamePlayViewModel.currentStage == .eighthStage ? // Gesture hanya aktif di eighthStage
                                    DragGesture()
                                        .onChanged { value in
                                            // Perbarui offset sementara saat kartu diseret
                                            gamePlayViewModel.dragOffset = value.translation
                                        }
                                        .onEnded { value in
                                            // Tentukan posisi akhir berdasarkan arah geser
                                            if value.translation.width < -100 {
                                                // Geser ke kiri
                                                gamePlayViewModel.isCardLeftAnimated = true
                                                gamePlayViewModel.isCardRightAnimated = false
                                            } else if value.translation.width > 100 {
                                                // Geser ke kanan
                                                gamePlayViewModel.isCardLeftAnimated = false
                                                gamePlayViewModel.isCardRightAnimated = true
                                            }
                                            
                                            // Reset drag offset
                                            withAnimation {
                                                gamePlayViewModel.dragOffset = .zero
                                            }
                                        } : nil // Tidak ada gesture di stage lain
                                )
                                .animation(.easeOut(duration: 1.0), value: gamePlayViewModel.isCardFourthAnimated || gamePlayViewModel.isSecondCenterAnimated || gamePlayViewModel.isThirdAnimated || gamePlayViewModel.isCardLeftAnimated || gamePlayViewModel.isCardRightAnimated)
                        }
                    }
                }
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.singElingDS30)
                        .frame(width: 298, height: 60)
                    
                    Text("Hai! yuk kita main tebak-tebakan!")
                        .font(.custom("Skrapbook", size: 20))
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                    
                    
                }
                .position(
                    x: 0.5 * vw,
                    y: gamePlayViewModel.isFifthTextDisappearing
                    ? vh + 150
                    : (gamePlayViewModel.isFifthTextAnimated ? targetPositionY : -100)
                )
                .onChange(of: gamePlayViewModel.isFifthTextAnimated) { animated in
                    if animated {
                        gamePlayViewModel.enableButton()
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.singElingDS30)
                        .frame(width: 351, height: 88)
                    
                    Text("Apakah kejadian di atas lebih sopan atau \ntidak sopan daripada kejadian di bawah?")
                        .font(.custom("Skrapbook", size: 20))
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                    
                    
                }
                .position(
                    x: 0.5 * vw,
                    y: gamePlayViewModel.isSixthTextDisappearing
                    ? vh + 150
                    : (gamePlayViewModel.isSixthTextAnimated ? targetPositionY : -100)
                )
                .onChange(of: gamePlayViewModel.isSixthTextAnimated) { animated in
                    if animated {
                        gamePlayViewModel.enableButton()
                    }
                }
                
                ZStack{
                    ArrowLineView(gamePlayViewModel: gamePlayViewModel)
                }
                .position(
                    x: gamePlayViewModel.isArrowLineDisappearing
                    ? 5 * vw // Bergerak jauh ke kanan jika menghilang
                    : (gamePlayViewModel.isFirstCenterAnimated
                       ? 0.1 * vw // Posisi kiri
                       : (gamePlayViewModel.isSecondCenterAnimated
                          ? 0.95 * vw // Posisi kanan
                          : 0.5 * vw)), // Posisi tengah
                    y: gamePlayViewModel.isArrowLineDisappearing ? targetPositionY - 50 : (gamePlayViewModel.isArrowLineAnimated ? targetPositionY : -100))
                .animation(.easeInOut(duration: 1.0), value: gamePlayViewModel.isFirstCenterAnimated || gamePlayViewModel.isSecondCenterAnimated)
                .onChange(of: gamePlayViewModel.isArrowLineAnimated) { animated in
                    if animated {
                        gamePlayViewModel.enableButton()
                    }
                }
                
                if gamePlayViewModel.isNinthStageVisible {
                    if gamePlayViewModel.isFirstDropZoneShow {
                        Dropzone(width: 30, height: 300, lineWidth: 4)
                            .position(
                                x: 0.2 * vw,
                                y: yPos * 4.7)  // Posisi DropZone 1
                            .opacity(1)  // Tampilkan DropZone 1
                            .animation(.easeInOut(duration: 1.0), value: gamePlayViewModel.isFirstDropZoneShow)
                            .onChange(of: gamePlayViewModel.isFirstDropZoneShow) { animated in
                                if animated{
                                    gamePlayViewModel.enableButton()
                                }
                            }
                    } else if gamePlayViewModel.isSecondDropZoneShow {
                        Dropzone(width: 30, height: 300, lineWidth: 4)
                            .position(
                                x: (gamePlayViewModel.isFirstCenterAnimated || gamePlayViewModel.isSecondCenterAnimated)
                                ? 0.5 * vw // Posisi sama jika salah satu kondisi true
                                : 0.8 * vw, // Posisi default jika kedua kondisi false
                                y: gamePlayViewModel.isThirdAnimated ? yPos * 4 : yPos * 4.7)
                            .opacity(1)
                            .animation(.easeInOut(duration: 1.0), value: gamePlayViewModel.isSecondDropZoneShow)
                            .onChange(of: gamePlayViewModel.isSecondDropZoneShow) { animated in
                                if animated{
                                    gamePlayViewModel.enableButton()
                                }
                            }
                    }
                }
                
                if gamePlayViewModel.isNinthStageVisible {
                    ZStack {
                        Jempol(width: 135, height: 196)
                            .frame(width: 70, height: 60)
                            .offset(
                                x: gamePlayViewModel.isLeftThumbAnimated ? (0.15 * vw - (vw / 2)) : (0.70 * vw - (vw / 2)),
                                y: gamePlayViewModel.isLeftThumbDisappearing ? vh : (gamePlayViewModel.isLeftThumbAnimated ? 310 : UIScreen.main.bounds.height)
                            )
                            .animation(.easeOut(duration: 1.0), value: gamePlayViewModel.isLeftThumbAnimated)
                            .animation(.easeIn(duration: 1.0), value: gamePlayViewModel.isLeftThumbDisappearing)
                            .onChange(of: gamePlayViewModel.isLeftThumbAnimated) { animated in
                                if animated {
                                    gamePlayViewModel.enableButton()
                                }
                            }
                        
                        Jempol(width: 135, height: 196)
                            .frame(width: 70, height: 60)
                            .offset(
                                x: (gamePlayViewModel.isFirstCenterAnimated || gamePlayViewModel.isSecondCenterAnimated)
                                ? (0.48 * vw - (vw / 2))
                                : (gamePlayViewModel.isRightThumbAnimated
                                   ? (0.75 * vw - (vw / 2))
                                   : (0.70 * vw - (vw / 2))),
                                y: gamePlayViewModel.isRightThumbDisappearing
                                ? vh
                                : (gamePlayViewModel.isThirdAnimated
                                   ? 310 - 30
                                   : (gamePlayViewModel.isRightThumbAnimated
                                      ? 310
                                      : UIScreen.main.bounds.height))
                                
                            )
                            .animation(.easeOut(duration: 1.0), value: gamePlayViewModel.isRightThumbAnimated || gamePlayViewModel.isRightThumbDisappearing)
                            .onChange(of: gamePlayViewModel.isRightThumbAnimated) { animated in
                                if animated {
                                    gamePlayViewModel.enableButton()
                                }
                            }
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.singElingDS30)
                        .frame(width: 298, height: 60)
                    
                    Text("Geser kiri dan kanan untuk memilih \nantara sopan atau tidak sopan!")
                        .font(.custom("Skrapbook", size: 20))
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                    
                    
                }
                .position(
                    x: 0.5 * vw,
                    y: gamePlayViewModel.isSeventhTextDisappearing
                    ? -150
                    : (gamePlayViewModel.isSeventhTextAnimated
                       ? targetPositionY
                       : -100)
                )
                .onChange(of: gamePlayViewModel.isSeventhTextAnimated) { animated in
                    if animated {
                        gamePlayViewModel.enableButton()
                    }
                }
                
                ZStack {
                    // Telunjuk
                    if gamePlayViewModel.isTelunjukTapRightAnimated{
                        if !gamePlayViewModel.isTapped {
                            Image("Telunjuk")
                                .resizable()
                                .frame(width: 83, height: 83)
                                .position(x: 0.8 * UIScreen.main.bounds.width, y: UIScreen.main.bounds.height * 0.68)
                                .offset(x: gamePlayViewModel.isTelunjukTapLeftAnimated ? -UIScreen.main.bounds.width * 0.6 : 0)
                                .transition(.opacity)
                                .animation(.easeInOut(duration: 1.0), value: gamePlayViewModel.isTelunjukTapLeftAnimated)
                        }
                        
                        // TelunjukTap
                        if gamePlayViewModel.isTapped {
                            Image("TelunjukTap")
                                .resizable()
                                .frame(width: 83, height: 83)
                                .position(x: 0.8 * UIScreen.main.bounds.width, y: UIScreen.main.bounds.height * 0.68)
                                .offset(x: gamePlayViewModel.isTelunjukTapLeftAnimated ? -UIScreen.main.bounds.width * 0.6 : 0)
                                .transition(.opacity)
                                .animation(.easeInOut(duration: 1.0), value: gamePlayViewModel.isTelunjukTapLeftAnimated)
                        }
                        
                    }
                    
                }
                .onAppear {
                    gamePlayViewModel.startTelunjukAnimation()
                }
                .onDisappear {
                    gamePlayViewModel.stopTelunjukAnimation()
                }

                if gamePlayViewModel.currentStage == .ninthStage {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.singElingDS30)
                            .frame(width: 298, height: 60)
                        
                        Text("Setelah mengetahui...")
                            .font(.custom("Skrapbook", size: 20))
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                        
                        
                    }
                    .position(
                        x: 0.5 * vw,
                        y: gamePlayViewModel.isTextNinthStageDisappearing
                        ? vh + 150
                        : (gamePlayViewModel.isEighthTextAnimated ? targetPositionY : -100)
                    )
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            withAnimation(.easeOut(duration: 1.0)) {
                                gamePlayViewModel.isEighthTextAnimated = true
                            }
                        }
                    }
                    .onChange(of: gamePlayViewModel.isEighthTextAnimated) { animated in
                        if animated {
                            gamePlayViewModel.isButtonEnabled = true
                        }
                    }
                    .animation(.easeOut(duration: 1.0), value: gamePlayViewModel.isTextNinthStageDisappearing)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.singElingDS30)
                            .frame(width: 360, height: 88)
                        
                        Text("1. Angka di kartu itu merepresentasikan \nindex ketidakesopanan")
                            .font(.custom("Skrapbook", size: 20))
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                        
                        
                    }
                    .position(
                        x: 0.5 * vw,
                        y: gamePlayViewModel.isTextNinthStageDisappearing
                        ? vh + 150
                        : (gamePlayViewModel.isNinthTextAnimated ? targetPositionY + 100 : -100)
                    )
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                            withAnimation(.easeOut(duration: 1.0)) {
                                gamePlayViewModel.isNinthTextAnimated = true
                            }
                        }
                    }
                    .onChange(of: gamePlayViewModel.isNinthTextAnimated) { animated in
                        if animated {
                            gamePlayViewModel.isButtonEnabled = false
                        }
                    }
                    .animation(.easeOut(duration: 1.0), value: gamePlayViewModel.isTextNinthStageDisappearing)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.singElingDS30)
                            .frame(width: 360, height: 88)
                        
                        Text("2. Semakin ke kanan semakin tidak sopan")
                            .font(.custom("Skrapbook", size: 20))
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                        
                        
                    }
                    .position(
                        x: 0.5 * vw,
                        y: gamePlayViewModel.isTextNinthStageDisappearing
                        ? vh + 150
                        : (gamePlayViewModel.isTenthTextAnimated ? targetPositionY + 200 : -100)
                    )
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
                            withAnimation(.easeOut(duration: 1.0)) {
                                gamePlayViewModel.isTenthTextAnimated = true
                            }
                        }
                    }
                    .onChange(of: gamePlayViewModel.isTenthTextAnimated) { animated in
                        if animated {
                            gamePlayViewModel.isButtonEnabled = false
                        }
                    }
                    .animation(.easeOut(duration: 1.0), value: gamePlayViewModel.isTextNinthStageDisappearing)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.singElingDS30)
                            .frame(width: 360, height: 88)
                        
                        Text("3. Cara menggeser dan meletakan \nkartu dengan gestur geser")
                            .font(.custom("Skrapbook", size: 20))
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                        
                        
                    }
                    .position(
                        x: 0.5 * vw,
                        y: gamePlayViewModel.isTextNinthStageDisappearing
                        ? vh + 150
                        : (gamePlayViewModel.isEleventhTextAnimated ? targetPositionY + 300 : -100)
                    )
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                            withAnimation(.easeOut(duration: 1.0)) {
                                gamePlayViewModel.isEleventhTextAnimated = true
                                
                            }
                        }
                    }
                    .onChange(of: gamePlayViewModel.isEleventhTextAnimated) { animated in
                        if animated {
                            print("Button enabled after eleventhText animation")
                            gamePlayViewModel.enableButton()
                        }
                    }
                    .animation(.easeOut(duration: 1.0), value: gamePlayViewModel.isTextNinthStageDisappearing)
                }
                
                if gamePlayViewModel.currentStage == .tenthStage || gamePlayViewModel.currentStage == .eleventhStage {
                    
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.singElingDS30)
                            .frame(width: 251, height: 88)
                        
                        Text("4. Sekarang, kita main dengan \n4 kartu yuk")
                            .font(.custom("Skrapbook", size: 20))
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                    }
                    .position(
                        x: 0.5 * vw,
                        y: gamePlayViewModel.isTwelfthTextDisappearing
                        ? vh + 150
                        : (gamePlayViewModel.isTwelfthTextAnimated ? targetPositionY : -100)
                    )
                    
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            withAnimation(.easeOut(duration: 1.0)) {
                                gamePlayViewModel.isTwelfthTextAnimated = true
                                
                            }
                        }
                    }
                    .onChange(of: gamePlayViewModel.isTwelfthTextAnimated) { animated in
                        if animated {
                            gamePlayViewModel.enableButton()
                        }
                    }
                    .animation(.easeOut(duration: 1.0), value: gamePlayViewModel.isTwelfthTextDisappearing)
                    
                    HStack (spacing: 10){
                        Image("Card25-tutorial")
                            .resizable()
                            .frame(width: 82, height: 137)
                            .padding()
                            .position(
                                x: 0.12 * vw,
                                y: yPos * 4.5
                            )
                            .offset(y: gamePlayViewModel.isFourCardAtTenthStageAnimated ? 0 : UIScreen.main.bounds.height + 50)
                        
                        Image("Card50-tutorial")
                            .resizable()
                            .frame(width: 82, height: 137)
                            .padding()
                            .position(
                                x: 0.1 * vw - 5,
                                y: yPos * 4.5
                            )
                            .offset(y: gamePlayViewModel.isFourCardAtTenthStageAnimated ? 0 : UIScreen.main.bounds.height + 50)
                        
                        Image("Card75-tutorial")
                            .resizable()
                            .frame(width: 82, height: 137)
                            .position(
                                x: 0.1 * vw,
                                y: yPos * 4.36
                            )
                            .padding()
                            .offset(y: gamePlayViewModel.isFourCardAtTenthStageAnimated ? 0 : UIScreen.main.bounds.height + 50)
                        
                        Image("Card100-tutorial")
                            .resizable()
                            .frame(width: 82, height: 137)
                            .position(
                                x: 0.1 * vw - 12,
                                y: yPos * 4.36
                            )
                            .padding()
                        //                            .zIndex(0)
                            .offset(y: gamePlayViewModel.isFourCardAtTenthStageAnimated ? 0 : UIScreen.main.bounds.height + 50)
                    }
                    .position(
                        x: 0.5 * vw,
                        y: gamePlayViewModel.isFourCardAtTenthStageDisappearing
                        ? vh + 150
                        : (gamePlayViewModel.isFourCardAtTenthStageAnimated ? targetPositionY + 150 : -100)
                    )
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            withAnimation(.easeOut(duration: 1.0)) {
                                gamePlayViewModel.isFourCardAtTenthStageAnimated = true
                                
                            }
                        }
                    }
                    .animation(.easeOut(duration: 1.0), value: gamePlayViewModel.isFourCardAtTenthStageAnimated)
                    
                    Dropzone(
                        width: gamePlayViewModel.isFourCardAtEleventhStageAnimated ? 24 : 13,
                        height: gamePlayViewModel.isFourCardAtEleventhStageAnimated ? 205 : 137,
                        lineWidth: gamePlayViewModel.isFourCardAtEleventhStageAnimated ? 4 : 2
                    )
                    .position(
                        x: 0.5 * UIScreen.main.bounds.width,
                        y: gamePlayViewModel.isFourCardAtEleventhStageAnimated
                        ? yPos * 4.65 // Posisi naik lebih tinggi
                        : (gamePlayViewModel.isFourCardAtTenthStageAnimated ? yPos * 5 : UIScreen.main.bounds.height * 0)
                    )
                                            .animation(.easeOut(duration: 1.0), value: gamePlayViewModel.isFourCardAtTenthStageAnimated)
                                            .animation(.easeInOut(duration: 1.0), value: gamePlayViewModel.isFourCardAtEleventhStageAnimated)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.easeOut(duration: 1.0)) {
                                gamePlayViewModel.isFourCardAtTenthStageAnimated = true
                            }
                        }
                    }
                    
                    .onChange(of: gamePlayViewModel.isFourCardAtEleventhStageAnimated) { isAnimated in
                        if isAnimated {
                            // Animasi pembesaran kartu
                            withAnimation(.easeInOut(duration: 2.0)) {
                               print("animasi kartu")
                            }
                        }
                    }
                    
                    if gamePlayViewModel.isFourCardAtEleventhStageAnimated || gamePlayViewModel.currentStage == .eleventhStage {
                        VStack {
                            Image("CardLandscape2")
                                .resizable()
                                .frame(width: 290, height: 100)
                                .position(x: 0.50 * vw, y: yPos * 1.5) // Posisi tetap pada x dan y
                                .offset(y: gamePlayViewModel.isCardLandscape2 ? 0 : -UIScreen.main.bounds.height)
                                .animation(.easeOut(duration: 1.0), value: gamePlayViewModel.isCardLandscape2)
                        }
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation {
                                    gamePlayViewModel.isCardLandscape2 = true
                                }
                            }
                        }

                        test()
                        .environmentObject(gamePlayViewModel)
                        
                        Jempol(width: 135, height: 196)
                            .frame(width: 70, height: 60)
                            .position(
                                x: 0.45 * UIScreen.main.bounds.width,
                                y: gamePlayViewModel.isThumbLastAnimated
                                ? targetPositionY + 400 // Berhenti di posisi target
                                : UIScreen.main.bounds.height + 100
                            )
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    withAnimation(.easeOut(duration: 1.0)) {
                                        gamePlayViewModel.isThumbLastAnimated = true
                                        
                                    }
                                }
                            }
                            .animation(.easeOut(duration: 1.0), value: gamePlayViewModel.isThumbLastAnimated)

                        
                        
                    }
                    
                    
                    if  gamePlayViewModel.isButtonClicked && gamePlayViewModel.currentStage == .eleventhStage{
                        if gamePlayViewModel.isAnswer == 2 {
                            SuccessOverlayView {
                                print("di game tutorial success")
                                gamePlayViewModel.isButtonClicked = false
                               
                            }
                        } else if gamePlayViewModel.isAnswer == 1 {
                            FailedOverlayView {
                                print("di game tutorial failed")
                                gamePlayViewModel.isButtonClicked = false
                            }
                        }
                    }

                }

                ZStack{
                    Image("Tiker Abu Terang")
                    
                        .resizable()
                        .scaledToFill()
                        .frame(width: vw * 2, height: vh * 0.2)
                        .position(x: vw / 2, y: vh * 2)
                        .shadow(color: .singGray, radius: 1, x: 0, y: 1)
                    
                    if gamePlayViewModel.currentStatusButton != nil{
                        // Gunakan StatusButtonComponent jika `currentStatusButton` ada nilainya
                        StatusButtonComponent(
                            width: 164,
                            height: 64,
                            action: {
                                
                                gamePlayViewModel.buttonPressed()
                            },
                            isButtonEnabled: $gamePlayViewModel.isButtonEnabled,
                            statusButtonModel: gamePlayViewModel.currentStatusButton!
                        )
                        .position(x: vw / 2, y: vh + 40)
                    }
                    else {
                        // Gunakan ButtonComponent jika `currentStatusButton` tidak diatur
//                        ButtonComponent(
//                            width: 190,
//                            height: 64,
//                            action: {
//                                gamePlayViewModel.buttonPressed()
//                            },
//                            isButtonEnabled: $gamePlayViewModel.isButtonEnabled,
//                            buttonModel: gamePlayViewModel.currentButton
//                        )
                        
                        //INI DIUBAH
                        ButtonComponent(
                            buttonModel: ButtonModel(button: .lanjut),
                            width: 190,
                            height: 64,
                            isButtonEnabled: .constant(true))
                        {
                            gamePlayViewModel.buttonPressed()
                        }
                        .position(x: vw / 2, y: vh + 40)
                    }
                }
            }
            .frame(width: vw, height: vh)
            .ignoresSafeArea()
            .onChange(of: geom.size) { oldValue, newValue in
                vw = newValue.width
                vh = newValue.height
            }
            .onAppear{
                vw = geom.size.width
                vh = geom.size.height
            }
            
            
            if gamePlayViewModel.vmode == 2 && gamePlayViewModel.isSuccessOverlayVisible {
                SuccessOverlayView{
                    gamePlayViewModel.nextStage()
                }
            }
            else if gamePlayViewModel.vmode == 1 && gamePlayViewModel.isFailedOverlayVisible{
                FailedOverlayView{
                    gamePlayViewModel.backStage()
                }
            }
        }
    }
}

struct ArrowLineView: View {
    @ObservedObject  var gamePlayViewModel = GamePlayViewModel()
    
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
                        .font(.custom("Skrapbook", size: gamePlayViewModel.isTextLeftArrowLine ? 24 : 16))
                        .padding(.leading, 0)
                    
                    Spacer()
                    
                    Text("LEBIH TIDAK SOPAN")
                        .font(.custom("Skrapbook", size: gamePlayViewModel.isTextRightArrowLine ? 24 : 16))
                        .padding(.trailing, 0)
                }
                .padding(.horizontal, 8)
            }
            .padding()
        }
    }
}

struct SuccessOverlayView: View {
    var action: () -> Void // Aksi yang dijalankan saat tombol ditekan
    @StateObject  var gamePlayViewModel = GamePlayViewModel()
    
    var body: some View {
        ZStack {
            Color.white
                .opacity(0.8)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 16) {
                Text("BERHASIL!")
                    .font(.custom("Skrapbook", size: 40))
                    .foregroundColor(.black)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.singElingLC10)
            )
            
            VStack{
                Text("Mantap! Siap buktikan lagi \ndi ronde berikutnya?")
                    .font(.custom("Skrapbook", size: 20))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding()
            }
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.singElingLC10)
            )
            .padding(.top, 170)
            
            VStack{
//                ButtonComponent(
//                    width: 190,
//                    height: 64,
//                    action: action,
//                    isButtonEnabled: .constant(true),
//                    buttonModel: ButtonModel(button: .lanjut)
//                )
                ButtonComponent(
                    buttonModel: ButtonModel(button: .lanjut),
                    width: 190,
                    height: 64,
                    isButtonEnabled: .constant(true))
                {
                    action()
                }
            }
            .padding(.top, 350)
            
        }
    }
}

struct FailedOverlayView: View {
    var action: () -> Void // Aksi yang dijalankan saat tombol ditekan
    @StateObject  var gamePlayViewModel = GamePlayViewModel()
    
    var body: some View {
        ZStack {
            Color.white
                .opacity(0.8)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 16) {
                Text("GAGAL!")
                    .font(.custom("Skrapbook", size: 40))
                    .foregroundColor(.black)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.singElingLC10)
            )
            
            VStack{
                Text("Hampir saja! Siap coba lagi \ndi ronde berikutnya?")
                    .font(.custom("Skrapbook", size: 20))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding()
            }
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.singElingLC10)
            )
            .padding(.top, 170)
            
            VStack{
                ButtonComponent(
                    buttonModel: ButtonModel(button: .lanjut),
                    width: 190,
                    height: 64,
                    isButtonEnabled: .constant(true))
                {
                    action()
                }
            }
            .padding(.top, 350)
        }
    }
}


#Preview {
    let buttonModel = ButtonModel(button: .mauLihat)
    GamePlayTutorial(
        gamePlayViewModel: GamePlayViewModel(),
        vw: 375,
        vh: 667
    )
    .environmentObject(GameManager())
}
