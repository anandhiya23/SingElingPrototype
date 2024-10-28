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
                .fill(Color.backgroundCream)
                .frame(width: width * 0.8, height: width * 0.25)
            
            VStack {
                HStack(spacing: 0) {
                    Text("INi GiLiRAN ")
                        .font(.custom("Skrapbook", size: width * 0.1))
                        .foregroundColor(.black)
                    
                    
                    ZStack {
                        Text("ANDA")
                            .font(.custom("Skrapbook", size: width * 0.1))
                            .foregroundColor(.black)
                            .offset(x: -1, y: -1)
                            .tracking(2)
                        
                        Text("ANDA")
                            .font(.custom("Skrapbook", size: width * 0.1))
                            .foregroundColor(.black)
                            .offset(x: 1, y: -1)
                            .tracking(2)
                        
                        Text("ANDA")
                            .font(.custom("Skrapbook", size: width * 0.1))
                            .foregroundColor(.black)
                            .offset(x: -1, y: 1)
                            .tracking(2)
                        
                        Text("ANDA")
                            .font(.custom("Skrapbook", size: width * 0.1))
                            .foregroundColor(.black)
                            .offset(x: 1, y: 1)
                            .tracking(2)
                        
                        Text("ANDA")
                            .font(.custom("Skrapbook", size: width * 0.1))
                            .foregroundColor(.singPink)
                            .tracking(2)
                    }
                }
                
                HStack {
                    Text("UNTUK")
                        .font(.custom("Skrapbook", size: width * 0.1))
                        .foregroundColor(.black)
                    
                    Text(statementRole.statementText)
                                        .font(.custom("Skrapbook", size: width * 0.1))
                                        .foregroundColor(.black)
                }
            }
        }
    }
}

#Preview {
    StatementComponent(width: 300, statementRole: StatementRole(userRole: .bystander))
}
