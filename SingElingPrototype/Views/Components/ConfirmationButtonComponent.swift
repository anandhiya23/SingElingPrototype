//
//  ConfirmationButtonComponent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 11/11/24.
//

import SwiftUI

struct ConfirmationButtonComponent: View {
    var width: CGFloat
    var height: CGFloat
    var action: () -> Void
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.855, green: 0.651, blue: 0.505))
                .frame(width: width, height: height)
                .offset(y: height / 7)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.black, lineWidth: 4) // Add stroke here
                        .frame(width: width, height: height)
                        .offset(y: height / 7)
                }
            
            
            RoundedRectangle(cornerRadius: 12)
                .fill(.singGray3)
                .frame(width: width, height: height)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.black, lineWidth: 4) // Add stroke here
                        .frame(width: width, height: height)
                }
            HStack{
                    
                Spacer()
                
                Text("Saya sudah mengerti!")
                    .font(.custom("Skrapbook", size: 20))
                    .foregroundColor(Color.singElingBlack)
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
        .onTapGesture {
                    action()
                }
        .frame(width: width, height: height)
    }
    }


#Preview {
    ConfirmationButtonComponent(width: 205, height: 64, action: {
        print("Button tapped")
    })
}
