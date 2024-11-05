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
    
    var body: some View {
        VStack{
            ZStack{
                if vmode == 0 {
                    Image("Bambu Merah 1")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                }
                if vmode == 1{
                    Image("Bambu Ijo 1")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                }
                if vmode == 2{
                    Image("Bambu Oren")
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                }
                
                
                HStack {
                    VStack{
                        Spacer()
                        if vmode == 0{
                            StatementComponent(width: 300, statementRole: StatementRole(userRole: .bystanderView))
                            HintComponent(hintModel: HintModel(userRole: .bystanderView, readerName: "Penebak"), width: 323)
                            CardComponent(width: 180, text: "Ora ngomong matur suwun sak wis e dibantu", indexNum: 1)
                                .padding()
                        }
                        if vmode == 1{
                            StatementComponent(width: 300, statementRole: StatementRole(userRole: .penebakView))
                            HintComponent(hintModel: HintModel(userRole: .penebakView, readerName: "Penebak"), width: 323)
                            CardComponent(width: 180, text: "Ora ngomong matur suwun sak wis e dibantu", indexNum: 1)
                                .padding()
                        }
                        if vmode == 2{
                            StatementComponent(width: 300, statementRole: StatementRole(userRole: .pembacaView))
                            HintComponent(hintModel: HintModel(userRole: .pembacaView, readerName: "Penebak"), width: 323)
                            CardComponent(width: 180, text: readerText, indexNum: readerNum)
                                .padding()
                        }
                        Spacer()
                    }
                    
                }
            }
        }
        
    }
}

#Preview {
    AnnouncementRoleView(vmode: 1)
}
