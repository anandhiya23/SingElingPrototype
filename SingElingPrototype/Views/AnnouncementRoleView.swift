//
//  AnnouncementRoleView.swift
//  SingElingPrototype
//
//  Created by Lazuardhi Imani Ahfar on 01/11/24.
//

import SwiftUI

struct AnnouncementRoleView: View {
    var vmode : Int = 0
    var byStander: Bool = false
    
    var body: some View {
        VStack {
            ZStack{
                if vmode == 1{
                    if byStander{
                        Image("Bambu Merah 1")
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea()
                    }else{
                        Image("Bambu Ijo 1")
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea()
                    }
                    
                }
                if vmode == 2{
                    Image("Bambu Oren")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                }
                
                
                HStack {
                    VStack{
                        Rectangle()
                            .frame(width: 394, height: 62)
                            .ignoresSafeArea()
                            .foregroundStyle(.singElingDS50)
                        Spacer()
                        if vmode == 1{
                            if byStander{
                                StatementComponent(width: 300, statementRole: StatementRole(userRole: .bystanderView))
                                HintComponent(hintModel: HintModel(userRole: .bystanderView, readerName: "Penebak"), width: 360)
                                CardComponent(width: 180, text: "Ora ngomong matur suwun sak wis e dibantu", indexNum: 1)
                                    .padding()
                            }else{
                                StatementComponent(width: 300, statementRole: StatementRole(userRole: .penebakView))
                                HintComponent(hintModel: HintModel(userRole: .pembacaView, readerName: "Penebak"), width: 360)
                                CardComponent(width: 180, text: "Ora ngomong matur suwun sak wis e dibantu", indexNum: 1)
                                    .padding()
                            }
                        }
                        
                        if vmode == 2{
                            StatementComponent(width: 300, statementRole: StatementRole(userRole: .pembacaView))
                            HintComponent(hintModel: HintModel(userRole: .pembacaView, readerName: "Penebak"), width: 360)
                            CardComponent(width: 180, text: "Ora ngomong matur suwun sak wis e dibantu", indexNum: 1)
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
    AnnouncementRoleView(vmode: 1, byStander: false)
}
