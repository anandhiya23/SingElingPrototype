//
//  TestGameView.swift
//  SingElingPrototype
//
//  Created by Bintang Anandhiya on 19/10/24.
//

import Foundation
import SwiftUI

struct TestGameView: View {
    @State var vw: CGFloat = 0
    @State var vh: CGFloat = 0
    var vmode: Int{
        2
    }
    @State var announcementRole : Bool = false
    @State var announcementGame : Bool = false
    @State private var roleTimer: Int = 0
    @State private var timer: Timer?

    
    @State var temptest = [0,1,2]
    @State var myCardPos = 4
    
    //tambahin ini
    @ObservedObject var gameManager = GameManager(username: "Haliza")
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
    
    @State var hintTapped: Bool = false
    @State var penebakTapped: Bool = false
    @State var pembacaTapped: Bool = false
    
    @State var oldColor: Color = .white
    @State var newColor: Color = .blue
    @State var playerColor: Color = Color.singElingSB10


    
    func startTimer() {
        resetTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            roleTimer += 1
            print("\(roleTimer)")
            if roleTimer == 1{
                hintTapped = false
                penebakTapped = false
                pembacaTapped = false
                
                announcementRole = true
                
                newColor = playerColor
                
            }
            if roleTimer == 3{
                hintTapped = true
                penebakTapped = true
                pembacaTapped = true
                
                oldColor = playerColor
            }
            if roleTimer == 7{
                hintTapped = false
                penebakTapped = false
                pembacaTapped = false
                
                announcementRole = false
            }
            if roleTimer == 8{
                withAnimation(.bouncy.speed(0.5)) {
                    announcementGame = false
                    
                    
                }
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
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        GeometryReader { geom in
            ZStack{
                Image("Bambu Oren")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                Image("Tikar Merah")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                    .frame(width: 1.2 * vw, height: vh)
                    .position(x: 1/2*vw, y: announcementGame ? 0.55*vh : 1.6*vh)
                    .shadow(color: .black,radius: 40)
                HStack{
                    Button("Announcement"){
                        withAnimation(.bouncy.speed(1.4)) {
                            print("tes")
                            announcementGame = true
                            startTimer()
//                            myCardPos = max(myCardPos - 1, 0)
                        }
                    }
                    .padding()
                    .foregroundStyle(.white)
                    .background{
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(.blue)
                    }
                    .position(x:vw*1/2, y: 0.9*vh)
//                    Button("Right"){
//                        withAnimation(.bouncy.speed(1.4)) {
//                            myCardPos = min(myCardPos + 1, temptest.count)
//                        }
//                    }
//                    .padding()
//                    .foregroundStyle(.white)
//                    .background{
//                        RoundedRectangle(cornerRadius: 10.0)
//                            .fill(.blue)
//                    }
//                    .font(.custom("Skrapbook", size: 24))
                }
                
                StatementComponent(width: 300, statementRole: StatementRole(userRole: .pembacaView))
                    .position(x:vw/2, y: announcementRole ? 26/100*vh : -145)
                    .animation(.bouncy.speed(1.5), value: announcementRole)
                HintComponent(hintModel: HintModel(userRole: .bystanderView, readerName: "Penebak"), width: 323)
                    .position(x:vw/2, y: announcementRole ? 40/100*vh : -145)
                    .animation(.bouncy.speed(0.3), value: announcementRole)
                
                //SELF'S CARDS
                
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(Color.black.opacity(0.7), style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [10,13]))
                    .frame(width: 170, height: 170*1.35)
                    .foregroundColor(.clear)
                    .position(x:vw/2, y: vmode == 0 || vmode == 1 ? 83.5/100*vh : 1.5*vh)
                ZStack(){
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(temptest.indices, id: \.self){ curCardIdIndice in
                            CardComponent(
                                width: 117,
                                                           text: gameManager.playingCards[curCardIdIndice].text,
                                                           indexNum: gameManager.playingCards[curCardIdIndice].indexNum,
                                backgroundImage: gameManager.getBackground(for: gameManager.playingCards[curCardIdIndice].indexNum)
                            )
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onEnded { gesture in
                                if gesture.translation.width > 50 {
                                    myCardPos = max(myCardPos - 1, 0)
                                } else if gesture.translation.width < -50 {
                                    myCardPos = min(myCardPos + 1, temptest.count)
                                }
                            }
                    )
//                    .padding(.leading, (vw/1.4) - CGFloat(myCardPos * 85))
                    .frame(width: vw, alignment: .leading)
                    .animation(.bouncy.speed(1.4), value: myCardPos)
                    
                }
                
                .position(x: vw/2, y: announcementRole ? 2*vh : 0.7*vh)
                .animation(.bouncy.speed(0.5), value: announcementRole)
                
                Jempol(width: 153, height: 222)
                    .frame(width: 70, height: 60)
                    .position(x:vw/2.1, y: announcementGame ? 1.5*vh : 0.73*vh)
                    .animation(.snappy.speed(0.4), value: announcementGame)
                
//                Rectangle()
//                    .fill(Color.singElingLC90)
//                    .frame(width: vw, height: 62)
//                    .position(x: 0.5*vw, y: 0.15*vh)
//                    .animation(.default, value: gameManager.gameState.announcementGame)
//                    .overlay(
//                        HStack{
//                            Text("penebeak")
//                                .font(.custom("Skrapbook", size: 32))
//                                .position(x: 0.5*vw, y: 0.15*vh)
//                                .foregroundColor(.white)
//                        }
//                    )
                
                Rectangle()
                    .fill(Color.singElingZ70)
                    .frame(width: vw, height: 62)
                    .position(x: 0.5*vw, y: 0.09*vh)
//                    .animation(.default, value: gameManager.gameState.announcementGame)
                    .overlay(
                        HStack{
                            Text("pembaca")
                                .font(.custom("Skrapbook", size: 32))
                                .position(x: 0.5*vw, y: 0.09*vh)
                                .foregroundColor(.white)
                        }
                    )
                
                Rectangle()
                    .fill(Color.singElingDS50)
                    .frame(width: vw, height: 62)
                    .position(x: 0.5*vw, y:0.03*vh)
                
                HintGameComponent(hintModel: HintModel(userRole: .pembacaView, readerName: "bintang"))
                    .frame(width: 180, height: 50)
                    .position(x: hintTapped ? 0.2 * vw : -0.1 * vw, y: 0.18 * vh)
                    .onTapGesture {
                        self.hintTapped.toggle()
                    }
                    .animation(.bouncy.speed(0.6), value: hintTapped)

                
                TurnDetailComponent(guesserName: "Haliza", imageName: "fluent-emoji_speaking-head", newColor: Color.singElingPG50, changeColor: announcementRole)
                    .frame(width: 140, height: 40)
                    .position(x: penebakTapped ? 0.9 * vw : 1.08 * vw, y: 0.18*vh)
                    .onTapGesture {
                        self.penebakTapped.toggle()
                    }
                    .animation(.bouncy.speed(0.6), value: penebakTapped)
                
                TurnDetailComponent(guesserName: "Haliza", imageName: "fluent-emoji_speaking-head", newColor: oldColor, changeColor: announcementRole)
                    .frame(width: 140, height: 40)
                    .position(x: pembacaTapped ? 0.9 * vw : 1.08 * vw, y: 0.24*vh)
                    .onTapGesture {
                        self.pembacaTapped.toggle()
                    }
                    .animation(.bouncy.speed(0.6), value: pembacaTapped)
                
                
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

#Preview {
    TestGameView()
}



