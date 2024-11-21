//
//  CodeRoomComponent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 04/11/24.
//

import SwiftUI

struct CodeRoomComponent: View {
    var onSelection: (Color, String) -> Void
    @State var vw: CGFloat = 0
    @State var vh: CGFloat = 0
    
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
                let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 4)
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(Array(roomIcons.enumerated()), id: \.offset) { index, iconModel in
                                        let color = iconModel.color.toColor()
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
        .frame(width: vw, height: vh)
    }
}

#Preview {
    CodeRoomComponent{ color, iconName in
        print("Selected color: \(color), iconName: \(iconName)")
    }
}

