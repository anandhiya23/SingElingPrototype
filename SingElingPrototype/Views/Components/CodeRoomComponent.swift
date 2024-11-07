//
//  CodeRoomComponent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 04/11/24.
//

import SwiftUI

struct CodeRoomComponent: View {
    var onSelection: (Color, String) -> Void
    
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
//                    ForEach(0..<roomIcons.count, id: \.self) { index in
//                        let iconModel = roomIcons[index]
//                                            let color = iconModel.color.toColor()  // Konversi CodableColor ke Color
//                                            let iconName = IconIdentifier(rawValue: iconModel.iconID)?.iconName() ?? "defaultIcon"
                    ForEach(Array(roomIcons.enumerated()), id: \.offset) { index, iconModel in
                                        let color = iconModel.color.toColor()  // Konversi CodableColor ke Color
                                        let iconName = IconIdentifier(rawValue: iconModel.iconID)?.iconName() ?? "defaultIcon"
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 3)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(color)
                                )
                                .frame(width: 60, height: 60)
                                .onTapGesture {
//                                                                    onSelection(roomIcons[index].color, roomIcons[index].iconName)
                                    onSelection(color, iconName)
                                                                }
                            Image(iconName)
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
    CodeRoomComponent{ color, iconName in
        // Preview untuk onSelection (contoh callback)
        print("Selected color: \(color), iconName: \(iconName)")
    }
}

