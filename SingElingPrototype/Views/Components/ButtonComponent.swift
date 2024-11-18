//
//  SetujuButton.swift
//  SingElingPrototype
//
//  Created by Lazuardhi Imani Ahfar on 24/10/24.
//

import SwiftUI

struct ButtonComponent: View {
    var buttonModel: ButtonModel
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
//                        .frame(width: width, height: height)
                        .frame(width: width, height: height)
                        .offset(y: height / 7)
                }
            
            
            RoundedRectangle(cornerRadius: 12)
                .fill(buttonModel.button == .yakin ? .singElingZ50 : (buttonModel.button == .tidak ? .singPink : .white))
                .frame(width: width, height: height)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.black, lineWidth: 4) // Add stroke here
                        .frame(width: width, height: height)
                }
            HStack{
                Image(buttonModel.imageName)
                    .resizable()
                    .frame(width: 51, height: 51)
                    .scaledToFit()
                    
//                Spacer()
                
                Text(buttonModel.buttonText)
                    .font(.custom("Skrapbook", size: 25))
                    .foregroundColor(Color.singElingBlack)
            }
            .frame(width: width, height: height)
            .padding()
        }
        .onTapGesture {
            action()
        print("button pressed")
        }
    }
}

#Preview {
    ButtonComponent(buttonModel: ButtonModel(button: .bergabung), width: 200, height: 64){
        print("Button tapped")
    }
}

