//
//  AnnouncementJuaraComponent.swift
//  SingElingPrototype
//
//  Created by Lazuardhi Imani Ahfar on 15/11/24.
//

import SwiftUI

struct AnnouncementJuaraComponent: View {
    var playerColor: Color = .singElingZ70
    var playerName: String = "Bintang"
    var width: CGFloat = 402
    var height: CGFloat = 874
    
    var body: some View {
        ZStack {
            ZStack{
                Image(systemName: "crown.fill")
                    .resizable()
                    .foregroundColor(playerColor)
                    .font(.body.weight(.light))

                Image(systemName: "crown")
                    .resizable()
                    .font(.body.weight(.light))
                
            }
            .frame(width: 105, height: 105)
            .position(x: 0.38 * width, y: -0.03 * height)
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.singElingLC10)
                
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.black, lineWidth: 4)
            }
            
            
            VStack{
                Text("Raja Jawanya")
                    .font(.custom("Skrapbook", size: 40))
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)
                HStack{
                    Text("Adalah")
                        .font(.custom("Skrapbook", size: 40))
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                    Text(playerName)
                        .font(.custom("Skrapbook", size: 40))
                        .foregroundColor(playerColor)
                        .multilineTextAlignment(.center)
                    Text("!")
                        .font(.custom("Skrapbook", size: 40))
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                }
            }
            .frame(width: 300, height: 96)
            
            
            HStack{
                Image("Jempol Kanan")
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(.degrees(-18.6))
                
                Spacer()

                Image("Jempol Kiri")
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(.degrees(18.6))

            }
            .frame(width: 380, height: 121)
            .position(x: 0.37 * width, y: 0.14 * height)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    AnnouncementJuaraComponent(playerColor: .singElingLC70, playerName: "abcdefgh")
        .frame(width: 270, height: 128)
}
