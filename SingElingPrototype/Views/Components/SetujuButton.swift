//
//  SetujuButton.swift
//  SingElingPrototype
//
//  Created by Lazuardhi Imani Ahfar on 24/10/24.
//

import SwiftUI

struct SetujuButton: View {
    var width: CGFloat
    var height: CGFloat
    var text: String
    var imageName: String
    var action: () -> Void
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 0.855, green: 0.651, blue: 0.505))
                .frame(width: width, height: height)
                .offset(y: height / 7)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 4) // Add stroke here
                        .frame(width: 164, height: 64)
                        .offset(y: height / 7)
                }
            
            
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(width: width, height: height)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 4) // Add stroke here
                        .frame(width: 164, height: 64)
                }
            HStack{
                Image(imageName)
                    .resizable()
                    .frame(width: 51, height: 51)
                    .scaledToFit()
                    
                Spacer()
                
                Text(text)
                    .font(.custom("Skrapbook", size: 25))
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
    SetujuButton(width: 164, height: 64, text: "Setuju!", imageName: "bi_hand-thumbs-up-fill") {
        print("Button pressed!")
    }
}

//struct SetujuButton: View {
//    var width: CGFloat
//    var height: CGFloat
//    var text: String
//    var imageName: String
//    var action: () -> Void
//    
//    var body: some View {
//        Button(action: {
//            action()
//        }) {
//            ZStack {
//                RoundedRectangle(cornerRadius: 20)
//                    .fill(Color(red: 0.855, green: 0.651, blue: 0.505))
//                    .frame(width: width, height: height)
//                    .offset(y: height / 7)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 20)
//                            .stroke(Color.black, lineWidth: 4)
//                            .frame(width: 164, height: 64)
//                            .offset(y: height / 7)
//                    )
//                
//                RoundedRectangle(cornerRadius: 20)
//                    .fill(.white)
//                    .frame(width: width, height: height)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 20)
//                            .stroke(Color.black, lineWidth: 4)
//                    )
//                
//                HStack {
//                    Image(imageName)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 51, height: 51)
//                    
//                    Text(text)
//                        .font(.custom("Skrapbook", size: 25))
//                }
//                .padding()
//            }
//        }
//        .buttonStyle(PlainButtonStyle())  // Remove default button styles if any
//        .frame(width: width, height: height)
//    }
//}

#Preview {
    SetujuButton(width: 164, height: 64, text: "Setuju!", imageName: "bi_hand-thumbs-up-fill") {
        print("Button pressed!")
    }
}

