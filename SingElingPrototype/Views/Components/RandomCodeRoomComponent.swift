//
//  CodeRoomComponent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 04/11/24.
//

import SwiftUI

struct RandomCodeRoomComponent: View {
    @State private var filledCount = 0
    @State private var shuffledIcons: [RoomIconModel] = roomIcons.shuffled()
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        VStack {
            let columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 4)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(0..<4, id: \.self) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.black, lineWidth: 3)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
//                                    .fill(index < filledCount ? shuffledIcons[index].color : Color.clear)
                                    .fill(index < filledCount ? shuffledIcons[index].color.toColor() : Color.clear)
                            )
                            .frame(width: 80, height: 80)
                        
                        if index < filledCount {
                            Image(shuffledIcons[index].iconName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            startFillingBoxes()
        }
    }
    
    private func startFillingBoxes() {
        
        
        gameManager.hostRoomCode = Array(Array(1..<roomIcons.count).shuffled().prefix(4))
        gameManager.initHost(myUsername: gameManager.myUsername)
        
        shuffledIcons = gameManager.hostRoomCode.map({ num in
            return roomIcons[num]
        })
        
        filledCount = 0
        var colors: [Color] = []
        var images: [String] = []
        
        // Isi colors dan images dari shuffledIcons
        for index in 0..<4 {
            //            colors.append(shuffledIcons[index].color)
            //            images.append(shuffledIcons[index].iconName)
            colors.append(shuffledIcons[index].color.toColor()) // Convert to Color
            images.append(shuffledIcons[index].iconName)
        }
        
        for index in 0..<roomIcons.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.5) {
                withAnimation {
                    filledCount += 1
                }
            }
        }
        
//        gameManager.generateRoomCode(colors: colors, images: images)
    }
}
