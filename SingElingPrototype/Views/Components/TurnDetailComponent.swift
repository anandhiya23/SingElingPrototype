//
//  TurnDetailView.swift
//  SingElingPrototype
//
//  Created by Lazuardhi Imani Ahfar on 11/11/24.
//

import SwiftUI

struct TurnDetailComponent: View {
    var guesserName: String
    let imageName: String
    var newColor: Color
    var changeColor: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(newColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.black, lineWidth: 4)
                )
                .animation(.default.speed(0.8), value: changeColor)
            HStack{
                
                Image(imageName)
                    .resizable()
                    .frame(width: 27, height: 27)
                    .padding(.leading, 10)
                
                Text(guesserName)
                    .font(.custom("Skrapbook", size: 16))
                    .foregroundColor(.black)
                Spacer()
                
            }
            
            
        }
    }
}


#Preview {
    TurnDetailComponent(guesserName: "Haliza", imageName: "Vector", newColor: Color.singElingPG50, changeColor: false)
}

