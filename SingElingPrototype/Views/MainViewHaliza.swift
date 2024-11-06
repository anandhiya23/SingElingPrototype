//
//  MainViewHaliza.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 01/11/24.
//
//import Foundation
//import SwiftUI
//
//struct MainViewHaliza: View {
//    @StateObject private var gameManager = GameManager(username: String(UUID().uuidString.prefix(6)))
//    @State var curView: Int = 0
//    @State var username = ""
//    
//    var body: some View {
//        switch curView {
//        case 1:
//            PairView(curView: $curView)
//                .environmentObject(gameManager)
//                .onAppear {
//                    print("Current view: \(curView)") // Debugging
//                }
//        case 2:
//            GameView()
//                .environmentObject(gameManager)
//        case 3:
//            EnterRoomView(curView: $curView)
//                .environmentObject(gameManager)
//        case 4:
//            //            SuccessfullyEnteredRoomView(curView: $curView)
//            //                .environmentObject(gameManager)
//            JoinRoomView(curView: $curView)
//                .environmentObject(gameManager)
//        case 5:
//            HostGenerateRoomView(curView: $curView)
//                .environmentObject(gameManager)
//        case 6:
//            //            JoinRoomView(curView: $curView)
//            //                .environmentObject(gameManager)
//            SuccessfullyEnteredRoomView(curView: $curView)
//                .environmentObject(gameManager)
//        case 7:
//            FailedEnteredRoomView(curView: $curView)
//                .environmentObject(gameManager)
//        default:
//            ZStack{
//                Rectangle()
//                    .fill(Color.singElingZ50)
//                    .ignoresSafeArea()
//                
//                VStack(spacing: 0){
//                    Text("Namamu siapa?")
//                        .font(.custom("skrapbook", size: 32))
//                        .padding()
//                    NameInputFormComponent(curView: $curView)
//                        .environmentObject(gameManager)
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    MainViewHaliza()
//}
