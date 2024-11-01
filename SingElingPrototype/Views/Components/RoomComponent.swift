//
//  RoomComponent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 01/11/24.
//

import SwiftUI

struct RoomComponent: View {
    @EnvironmentObject var gameManager: GameManager
    @Binding var curView: Int
    var roomModel: RoomModel
    var width: CGFloat
    
    var body: some View {
        HStack {
            Image(roomModel.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: width * (30 / 300), height: width * (30 / 222))

            Text(roomModel.text)
                .font(.custom("Skrapbook", size: width * 0.1))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .font(.custom("Skrapbook", size: width * (23 / 222)))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: width * (8 / 222))
                .fill(Color.backgroundCream)
        )
        .overlay(
            RoundedRectangle(cornerRadius: width * (8 / 222))
                .stroke(Color.black, lineWidth: 5)
        )
        .padding(.horizontal)
        .onTapGesture {
                    curView = 1
            print("ditekan")
                }
    }
}


#Preview {
    @State var curView: Int = 0
        
        return RoomComponent(curView: $curView, roomModel: RoomModel(typeRoom: .createRoom), width: 300)
            .environmentObject(GameManager(username: "PreviewUser"))
}
