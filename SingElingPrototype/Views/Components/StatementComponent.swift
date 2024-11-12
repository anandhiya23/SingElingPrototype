//
//  StatementComponent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 24/10/24.
//

import SwiftUI

struct StatementComponent: View {
    var width: CGFloat
    var statementRole: StatementRole
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.singElingLC10)
                .frame(width: width * 0.9, height: width * 0.35)
            
//            VStack {
//                HStack(spacing: 0) {
//                    Text("INi GiLiRAN ")
//                        .font(.custom("Skrapbook", size: width * 0.1))
//                        .foregroundColor(Color.singElingBlack)
//                    
//                    
//                    ZStack {
//                        Text("ANDA")
//                            .font(.custom("Skrapbook", size: width * 0.1))
//                            .foregroundColor(Color.singElingBlack)
//                            .offset(x: -1, y: -1)
//                            .tracking(2)
//                        
//                        Text("ANDA")
//                            .font(.custom("Skrapbook", size: width * 0.1))
//                            .foregroundColor(Color.singElingBlack)
//                            .offset(x: 1, y: -1)
//                            .tracking(2)
//                        
//                        Text("ANDA")
//                            .font(.custom("Skrapbook", size: width * 0.1))
//                            .foregroundColor(Color.singElingBlack)
//                            .offset(x: -1, y: 1)
//                            .tracking(2)
//                        
//                        Text("ANDA")
//                            .font(.custom("Skrapbook", size: width * 0.1))
//                            .foregroundColor(Color.singElingBlack)
//                            .offset(x: 1, y: 1)
//                            .tracking(2)
//                        
//                        Text("ANDA")
//                            .font(.custom("Skrapbook", size: width * 0.1))
//                            .foregroundColor(.singPink)
//                            .tracking(2)
//                    }
//                }
//                
//                HStack {
//                    Text("UNTUK")
//                        .font(.custom("Skrapbook", size: width * 0.1))
//                        .foregroundColor(Color.singElingBlack)
//                    
//                    Text(statementRole.statementText)
//                                        .font(.custom("Skrapbook", size: width * 0.1))
//                                        .foregroundColor(Color.singElingBlack)
//                }
//            }
            VStack{
                Text(statementRole.statementText ?? "")
                    .font(.custom("Skrapbook", size: width * 0.1))
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    StatementComponent(width: 300, statementRole: StatementRole(userRole: .createRoomView))
}
