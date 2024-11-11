//
//  StatusButtonComponent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 10/11/24.
//

import SwiftUI

struct StatusButtonComponent: View {
    var width: CGFloat
    var height: CGFloat
    var action: () -> Void
    
    var statusButtonModel: StatusButtonModel
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.855, green: 0.651, blue: 0.505))
                .frame(width: width, height: height)
                .offset(y: height / 7)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.black, lineWidth: 4)
                        .frame(width: 164, height: 64)
                        .offset(y: height / 7)
                }
            
            
            RoundedRectangle(cornerRadius: 12)
                .fill(statusButtonModel.fillColor)
                .frame(width: width, height: height)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.black, lineWidth: 4)
                        .frame(width: 164, height: 64)
                }
            HStack{
                Image(statusButtonModel.imageName)
                    .resizable()
                    .frame(width: 51, height: 51)
                    .scaledToFit()
                    
                Spacer()
                
                Text(statusButtonModel.statusButtontext)
                    .font(.custom("Skrapbook", size: 25))
                    .foregroundColor(Color.singElingBlack)
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
    StatusButtonComponent(width: 164, height: 64, action: {
        print("Button tapped")
    }, statusButtonModel: StatusButtonModel(statusButton: .tidak))
}
