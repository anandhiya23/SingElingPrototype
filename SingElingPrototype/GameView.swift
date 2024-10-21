//
//  ContentView.swift
//  SingElingPrototype
//
//  Created by Bintang Anandhiya on 16/10/24.
//

import SwiftUI

struct CircleButton: View {
    var diameter: CGFloat
    var icon: String = "arrow.left"
    
    @State private var isPressed: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.black.opacity(0.3))
                .scaleEffect(x: 1.15, y: 1.13)
                .frame(width: diameter)
                .offset(y: diameter / 9)
            
            Circle()
                .fill(Color.singButtonLight)
                .shadow(color: Color.singButtonDark.opacity(isPressed ? 0 : 1),
                        radius: 0,
                        x: 0,
                        y: diameter / 9)
                .overlay(
                    Image(systemName: icon)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                )
                .frame(width: diameter)
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .offset(y: isPressed ? diameter / 9 : 0)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isPressed = true
                        playClick()
                    }completion: {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            isPressed = false
                        }
                    }
                }
        }
        .frame(width: diameter, height: diameter)
    }
}


struct PillButton: View {
    var width: CGFloat
    var height: CGFloat
    var icon: String = "arrow.left"

    @State private var isPressed: Bool = false
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(.black.opacity(0.3))
                .scaleEffect(x: 1.1, y: 1.13)
                .frame(width: width, height: height)
                .offset(y: height / 9)

            Capsule()
                .fill(Color.singButtonLight)
                .shadow(color: Color.singButtonDark.opacity(isPressed ? 0 : 1),
                        radius: 0,
                        x: 0,
                        y: height / 9)
                .overlay(
                    Image(systemName: icon)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                )
                .frame(width: width, height: height)
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .offset(y: isPressed ? height / 9 : 0)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isPressed = true
                        playClick()
                    }completion: {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            isPressed = false
                        }
                    }
                }
        }
        .frame(width: width, height: height + (height / 9))
    }
}


struct CardView: View{
    var width: CGFloat
    private var height: CGFloat{
        get{
            self.width * 1.35
        }
    }
    
    var hidden = true
    var text = "Ducimus et cupiditate aliquid nam molestiae."
    var icon = ""
    var indexnum = 30
    
    var body: some View {
        
        ZStack(){
            RoundedRectangle(cornerRadius: width/20)
                .fill(Color.white)
            
            if(hidden){
                Image(systemName:"questionmark")
                    .resizable()
                    .scaledToFit()
                    .fontWeight(.heavy)
                    .padding(width/3)
            }else{
                VStack(alignment:.leading,spacing: width/18){
                    Text(text)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: width/14))
                    Image(systemName: icon)
                        .font(.system(size: width/5))
                    Text("\(indexnum)")
                        .font(.system(size: width/5))
                        .fontWeight(.heavy)
                }
                .padding(width/6)
            }
        }
        .frame(width: width, height: height)
        .background{
            RoundedRectangle(cornerRadius: width/20)
                .padding(.leading, -width/30)
                .opacity(0.1)
        }
    }
    
}
struct RoundedTriangle: Shape {
    var cornerRadius: CGFloat = 20.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Define the points of the triangle
        let top = CGPoint(x: rect.midX, y: rect.minY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        
        // Move to the initial point (top of the triangle)
        path.move(to: CGPoint(x: top.x, y: top.y))
        
        // Draw a line from the top to the bottom-left with a corner radius
        path.addArc(
            tangent1End: top,
            tangent2End: bottomLeft,
            radius: cornerRadius
        )
        
        // Draw a line from the bottom-left to the bottom-right with a corner radius
        path.addArc(
            tangent1End: bottomLeft,
            tangent2End: bottomRight,
            radius: cornerRadius
        )
        
        // Draw a line from the bottom-right back to the top with a corner radius
        path.addArc(
            tangent1End: bottomRight,
            tangent2End: top,
            radius: cornerRadius
        )
        
        path.addArc(
            tangent1End: top,
            tangent2End: bottomLeft,
            radius: cornerRadius
        )
        
        path.closeSubpath()
        
        return path
    }
}

struct GameView: View {
    @EnvironmentObject var gameManager: GameManager
    @State var vw: CGFloat = 0
    @State var vh: CGFloat = 0
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
                
                if gameManager.gameState.winner_PID != nil{
                    ZStack{
                        VStack{
                            Text("Selamat kepada")
                            Text(gameManager.winnerName)
                                .bold()
                                .font(.title)
                            Text("8/8 Kartu")
                            Spacer().frame(height: 20)
                            if gameManager.isHost{
                                Button("Main Lagi"){
                                    gameManager.startGame()
                                }
                                .padding()
                                .foregroundStyle(Color.white)
                                .background{
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.black)
                                }
                            }
                        }
                    }
                    .frame(width: vw, height: vh)
                    .background(Color.singGreen)
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

//#Preview {
//    GameView()
//}
