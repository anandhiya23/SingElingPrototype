//
//  AnnouncementRoleView.swift
//  SingElingPrototype
//
//  Created by Lazuardhi Imani Ahfar on 01/11/24.
//

import SwiftUI

struct AnnouncementRoleView: View {
    var vmode : Int = 0
    
    var body: some View {
        ZStack{
            Image("Bambu Oren")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            HStack {
                if vmode == 1{
                    VStack {
                        StatementComponent(width: 300, statementRole: StatementRole(userRole: .penebakView))
                        HintComponent(hintModel: HintModel(userRole: .pembacaView, readerName: "Penebak"), width: 360)
                        CardComponent(width: 180, text: "Ora ngomong matur suwun sak wis e dibantu", indexNum: 1)
                            .padding()
                    }
                }
                if vmode == 2{
                    VStack {
                        StatementComponent(width: 300, statementRole: StatementRole(userRole: .pembacaView))
                        HintComponent(hintModel: HintModel(userRole: .pembacaView, readerName: "Penebak"), width: 360)
                        CardComponent(width: 180, text: "Ora ngomong matur suwun sak wis e dibantu", indexNum: 1)
                            .padding()
                    }
                }
                
            }
            
        }
    }
}

#Preview {
    AnnouncementRoleView(vmode: 2)
}
