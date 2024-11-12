//
//  AnnouncementRoleView.swift
//  SingElingPrototype
//
//  Created by Lazuardhi Imani Ahfar on 01/11/24.
//

import SwiftUI

struct AnnouncementRoleView: View {
    var vmode : Int = 0
    var readerText : String = ""
    var readerNum : Int = 0
    var readerBackgroundImage: String = ""
    
    var playerColor: CodableColor
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        VStack{
            ZStack{
//                if vmode == 0 {
//                    Image("Bambu Merah 1")
//                        .resizable()
//                        .scaledToFill()
//                        .ignoresSafeArea()
//                }
//                if vmode == 1{
//                    Image("Bambu Ijo 1")
//                        .resizable()
//                        .scaledToFill()
//                        .ignoresSafeArea()
//                }
//                if vmode == 2{
//                    Image("Bambu Oren")
//                        .resizable()
//                        .scaledToFit()
//                        .ignoresSafeArea()
//                }
                Image(gameManager.getBackgroundImage(for: playerColor))
                                    .resizable()
                                    .scaledToFill()
                                    .ignoresSafeArea()
                
                
                HStack {
                    VStack{
                        Spacer()
                        if vmode == 0{
                            StatementComponent(width: 300, statementRole: StatementRole(userRole: .bystanderView))
<<<<<<< Updated upstream
                            HintComponent(hintModel: HintModel(userRole: .bystanderView, readerName: "Penebak"), width: 323)
                            CardComponent(width: 200, text: "Sing Eling", indexNum: 100, backgroundImage: readerBackgroundImage)
=======
                            HintComponent(hintModel: HintModel(userRole: .bystanderView, readerName: "Penebak"), width: 323, highlightedColor: gameManager.currentUserColor)
                            CardComponent(width: 200, text: "Sing Eling", indexNum: 0)
>>>>>>> Stashed changes
                                .padding()
                        }
                        if vmode == 1{
                            StatementComponent(width: 300, statementRole: StatementRole(userRole: .penebakView))
<<<<<<< Updated upstream
                            HintComponent(hintModel: HintModel(userRole: .penebakView, readerName: "Penebak"), width: 323)
                            CardComponent(width: 200, text: "Sing Eling", indexNum: 99, backgroundImage: readerBackgroundImage)
=======
                            HintComponent(hintModel: HintModel(userRole: .penebakView, readerName: "Penebak"), width: 323, highlightedColor: gameManager.currentUserColor)
                            CardComponent(width: 200, text: "Sing Eling", indexNum: 0)
>>>>>>> Stashed changes
                                .padding()
                        }
                        if vmode == 2{
                            StatementComponent(width: 300, statementRole: StatementRole(userRole: .pembacaView))
<<<<<<< Updated upstream
                            HintComponent(hintModel: HintModel(userRole: .pembacaView, readerName: "Penebak"), width: 323)
                            CardComponent(width: 200, text: readerText, indexNum: readerNum, backgroundImage: readerBackgroundImage)
=======
                            HintComponent(hintModel: HintModel(userRole: .pembacaView, readerName: "Penebak"), width: 323, highlightedColor: gameManager.currentUserColor)
                            CardComponent(width: 200, text: readerText, indexNum: readerNum)
>>>>>>> Stashed changes
                                .padding()
                        }
                        Spacer()
                    }
                    
                }
            }
        }
        
    }
}

//#Preview {
////    AnnouncementRoleView(vmode: 1)
//    AnnouncementRoleView(playerColor: CodableColor(color: .singElingLC50))
//            .environmentObject(GameManager(username: "Haliza"))
//}
