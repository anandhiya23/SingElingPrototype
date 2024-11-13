////
////  OnBoarding.swift
////  SingElingPrototype
////
////  Created by Haliza Syafa Oktaviani on 11/11/24.
////
//
//import SwiftUI
//
//struct OnBoardingView: View {
//    @EnvironmentObject var gameManager: GameManager
//    @State var curView: Int = 0
//  
//    
//    var body: some View {
//        switch curView {
//        case 1:
//            print("")
//            PairView(curView: $curView)
//                .environmentObject(gameManager)
//        case 2:
//            GameView()
//                .environmentObject(gameManager)
//        case 3:
//            PairViewContent(curView: $curView)
//                .environmentObject(gameManager)
//        case 4:
//            BintangDragDropView2(curView: $curView)
//                .environmentObject(gameManager)
//        case 5:
//            CountdownView(curView: $curView)
//                .environmentObject(gameManager)
//        case 6:
//            OnboardingContainerView()
//                .environmentObject(gameManager)
//        default:
//            ZStack{
//                Image("OnBoardingBackground")
//                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea()
//
//                VStack(alignment: .center){
//                    Image("LogoFinal")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 160, height: 160)
//                        .padding()
//                    
//                    Text("Yuk Kita Simak \nDulu tutorialnya!")
//                        .font(.custom("skrapbook", size: 40))
//                        .foregroundColor(Color.singElingRB50)
//                        .multilineTextAlignment(.center)
//                    
//                    ButtonComponent(width: 220, height: 64, action: {
//                        curView = 6
//                        
//                    }, buttonModel: ButtonModel(button: .mauLihat))
//                    
//                    .padding()
//                    
//                    ConfirmationButtonComponent(width: 205, height: 64, action: {
//                        print("Button tapped")
//                    })
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    OnBoardingView()
//        .environmentObject(GameManager())
//}

