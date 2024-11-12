//
//  OnBoarding.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 11/11/24.
//

import SwiftUI

struct OnBoardingView: View {
<<<<<<< Updated upstream
    @EnvironmentObject var gameManager: GameManager
    @State var curView: Int = 0
  
    
    var body: some View {
        switch curView {
        case 1:
            PairView(curView: $curView)
                .environmentObject(gameManager)
        case 2:
            GameView()
                .environmentObject(gameManager)
        case 3:
            PairViewContent(curView: $curView)
                .environmentObject(gameManager)
        case 4:
            BintangDragDropView2(curView: $curView)
                .environmentObject(gameManager)
        case 5:
            CountdownView(curView: $curView)
                .environmentObject(gameManager)
        case 6:
            OnboardingContainerView()
                .environmentObject(gameManager)
=======
    @StateObject private var gameManager = GameManager(username: String(UUID().uuidString.prefix(6)))
    @State var curView: Int = 0
    @StateObject private var timerManager = ButtonTimerManager()
    
    var body: some View {
        switch curView{
        case 1:
            PairView(curView: $curView)
                            .environmentObject(gameManager)
        case 2:
            GameView()
                            .environmentObject(gameManager)
        case 3:
            PairViewContent(curView: $curView)
                            .environmentObject(gameManager)
        case 4:
            BintangDragDropView2(curView: $curView)
                            .environmentObject(gameManager)
        case 5:
            CountdownView(curView: $curView)
                            .environmentObject(gameManager)
        case 6:
            OnboardingContainerView()
                .environmentObject(gameManager)
        case 7:
            MainView(curView: $curView)
                .environmentObject(gameManager)
        case 8:
            GamePlayTutorial(curView: $curView)
                .environmentObject(gameManager)
            
>>>>>>> Stashed changes
        default:
            ZStack{
                Image("OnBoardingBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
<<<<<<< Updated upstream
                
=======
                   
>>>>>>> Stashed changes
                VStack(alignment: .center){
                    Image("LogoFinal")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                        .padding()
                    
                    Text("Yuk Kita Simak \nDulu tutorialnya!")
                        .font(.custom("skrapbook", size: 40))
                        .foregroundColor(Color.singElingRB50)
                        .multilineTextAlignment(.center)
                    
                    ButtonComponent(width: 220, height: 64, action: {
<<<<<<< Updated upstream
                        curView = 6
=======
//                        curView = 6
                        curView = 99  // Nilai sementara untuk memicu refresh
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            curView = 8
                        }
                        print("curview: \(curView)")
>>>>>>> Stashed changes
                    }, buttonModel: ButtonModel(button: .mauLihat))
                    
                    .padding()
                    
                    ConfirmationButtonComponent(width: 205, height: 64, action: {
<<<<<<< Updated upstream
                        print("Button tapped")
=======
                        curView = 7
                        print("curview: \(curView)")
>>>>>>> Stashed changes
                    })
                }
            }
        }
    }
}

#Preview {
    OnBoardingView()
<<<<<<< Updated upstream
        .environmentObject(GameManager(username: "haliza"))
=======
//        .environmentObject(GameManager(username: "haliza"))
>>>>>>> Stashed changes
}
