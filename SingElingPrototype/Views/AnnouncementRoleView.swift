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
                Image(gameManager.getBackgroundImage(for: playerColor))
                                    .resizable()
                                    .scaledToFill()
                                    .ignoresSafeArea()
                
                
                HStack {
                    VStack{
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
