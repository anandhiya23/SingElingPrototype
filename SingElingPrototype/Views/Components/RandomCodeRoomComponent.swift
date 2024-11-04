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
                                    .fill(index < filledCount ? shuffledIcons[index].color : Color.clear)
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
        shuffledIcons = roomIcons.shuffled()
        filledCount = 0
        
        for index in 0..<roomIcons.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.5) {
                withAnimation {
                    filledCount += 1
                }
            }
        }
    }
}

#Preview {
    RandomCodeRoomComponent()
}
