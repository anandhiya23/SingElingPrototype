//
<<<<<<< Updated upstream
//  GameViewTutorial.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 12/11/24.
=======
//  GamePlayTutorial.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 11/11/24.
>>>>>>> Stashed changes
//

import SwiftUI

struct GamePlayTutorial: View {
    @EnvironmentObject var gameManager: GameManager
    @State private var vw: CGFloat = 0
    @State private var vh: CGFloat = 0
<<<<<<< Updated upstream
=======
    @Binding var curView: Int
>>>>>>> Stashed changes
    
    var body: some View {
        GeometryReader { geom in
            ZStack {
                BackgroundView()
                
                VStack(spacing: 0) {
                    HeaderView()
                    Spacer(minLength: 0)
                    RoleTitleView(role: "Penebak")
                    Spacer(minLength: 20)
<<<<<<< Updated upstream
                    CenterCardsView()
                    Spacer(minLength: 40)
                    LockButtonView()
                }
                .frame(width: vw, height: vh)
            }
            .onAppear {
                vw = geom.size.width
                vh = geom.size.height
            }
            .ignoresSafeArea()
=======
                    Spacer(minLength: 40)
                    ButtonComponent(width: 164, height: 64, action: {
                        print("Button tapped")
                    }, buttonModel: ButtonModel(button: .kunci))
                }
                .frame(width: geom.size.width, height: geom.size.height) // Set frame to screen size
            }
            .frame(width: geom.size.width, height: geom.size.height)  // Center ZStack in GeometryReader
            
>>>>>>> Stashed changes
        }
    }
}

struct BackgroundView: View {
    var body: some View {
<<<<<<< Updated upstream
        Image("DefaultBackground") // Replace with dynamic background if needed
=======
        Image("Tikar Abu")
>>>>>>> Stashed changes
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

struct HeaderView: View {
    var body: some View {
        HStack {
<<<<<<< Updated upstream
            Button(action: {
                // Action for "KELUAR" button
            }) {
                Text("KELUAR")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
            }
            
            Spacer()
            
            Text("Ray 4/5")
                .font(.headline)
                .foregroundColor(.black)
                .padding()
                .background(Color.yellow)
                .cornerRadius(8)
=======
            Spacer()
>>>>>>> Stashed changes
        }
        .padding()
        .background(Color.singElingDS50)
    }
}

struct RoleTitleView: View {
    let role: String
    
    var body: some View {
        Text(role)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.vertical, 10)
            .background(Color.singElingZ70)
            .cornerRadius(10)
    }
}

<<<<<<< Updated upstream
struct CenterCardsView: View {
    @EnvironmentObject var gameManager: GameManager
    @State private var vw: CGFloat = UIScreen.main.bounds.width
    @State private var vh: CGFloat = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            HStack(spacing: 16) {
                ForEach(0..<gameManager.guesserCards.count, id: \.self) { curCardIdIndice in
                    let curCardId = gameManager.guesserCards[curCardIdIndice]
                    let tempCard: PlayingCard = gameManager.playingCards[curCardId]
                    
                    CardComponent(
                        width: 147,
                        text: tempCard.text,
                        indexNum: tempCard.indexNum,
                        backgroundImage: gameManager.getBackground(for: tempCard.indexNum)
                    )
                    .padding(.leading, curCardIdIndice == gameManager.guesserCardPos ? 20 : (curCardIdIndice == gameManager.guesserCardPos + 1 ? 60 : -80))
                }
            }
            .padding(.leading, (vw / 2) - CGFloat(gameManager.guesserCardPos * 85))
            .frame(width: vw, alignment: .leading)
            
            // Finger indicator between cards
            Jempol(width: 135, height: 196)
                .rotationEffect(Angle(degrees: 180))
                .frame(width: 70, height: 60)
                .position(x: vw / 1.9, y: 50) // Adjusted Y-position for placement
        }
    }
}

struct LockButtonView: View {
    var body: some View {
        Button(action: {
            // Action for lock button
        }) {
            HStack {
                Image(systemName: "key.fill")
                Text("Kunci")
                    .fontWeight(.bold)
            }
            .foregroundColor(.white)
            .padding()
            .frame(width: 164, height: 64)
            .background(Color.black)
            .cornerRadius(10)
        }
    }
}

struct GamePlayTutorial_Previews: PreviewProvider {
    static var previews: some View {
        GamePlayTutorial()
            .environmentObject(GameManager(username: "hhh")) // Provide GameManager for preview
    }
}
=======
//struct CenterCardsView: View {
//    @EnvironmentObject var gameManager: GameManager
//    @State private var vw: CGFloat = UIScreen.main.bounds.width
//    @State private var vh: CGFloat = UIScreen.main.bounds.height
//    
//    var body: some View {
//        ZStack {
//            HStack(spacing: 16) {
//                ForEach(0..<gameManager.guesserCards.count, id: \.self) { curCardIdIndice in
//                    let curCardId = gameManager.guesserCards[curCardIdIndice]
//                    let tempCard: PlayingCard = gameManager.playingCards[curCardId]
//                    
//                    CardComponent(
//                        width: 147,
//                        text: tempCard.text,
//                        indexNum: tempCard.indexNum
//                    )
//                    .padding(.leading, curCardIdIndice == gameManager.guesserCardPos ? 20 : (curCardIdIndice == gameManager.guesserCardPos + 1 ? 60 : -80))
//                }
//            }
//            .padding(.leading, (vw / 2) - CGFloat(gameManager.guesserCardPos * 85))
//            .frame(width: vw, alignment: .leading)
//            
//            Jempol(width: 135, height: 196)
//                .rotationEffect(Angle(degrees: 180))
//                .frame(width: 70, height: 60)
//                .position(x: vw / 1.9, y: 50)
//        }
//    }
//}

struct GamePlayTutorial_Previews: PreviewProvider {
    static var previews: some View {
        GamePlayTutorial(curView: .constant(0))
            .environmentObject(GameManager(username: "hhh"))
    }
}


>>>>>>> Stashed changes
