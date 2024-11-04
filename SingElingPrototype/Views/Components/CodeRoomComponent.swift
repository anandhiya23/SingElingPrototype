//
//  CodeRoomComponent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 04/11/24.
//

import SwiftUI

struct CodeRoomComponent: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.singElingSB50)
                .frame(width: 330, height:176)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.black, lineWidth: 4)
                        .frame(width: 330, height: 176)
                }
            VStack {
                let columns = Array(repeating: GridItem(.flexible(), spacing: -50), count: 4)
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(0..<roomIcons.count, id: \.self) { index in
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 3)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(roomIcons[index].color)
                                )
                                .frame(width: 60, height: 60)
                            
                            Image(roomIcons[index].iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    CodeRoomComponent()
}

