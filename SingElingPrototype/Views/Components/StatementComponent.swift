//
//  StatementComponent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 24/10/24.
//

import SwiftUI

struct StatementComponent: View {
    var width: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.backgroundCream)
                .frame(width: width, height: width * 0.3)
            
            VStack {
                HStack(spacing: 0) {
                    Text("INI GILIRAN ")
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
                
                Text("UNTUK MEMANTAU")
                    .font(.custom("Skrapbook", size: width * 0.1))
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    StatementComponent(width: 350)
}
