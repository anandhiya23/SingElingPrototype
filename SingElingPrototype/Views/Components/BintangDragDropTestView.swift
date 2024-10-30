//
//  BintangDragDropView.swift
//  SingElingPrototype
//
//  Created by Bintang Anandhiya on 28/10/24.
//

import SwiftUI
import Foundation



struct BintangDragDropView: View {
    @State var isDragging = false
    @State var draggedIndex = -1
    @State var dropIndex = -1
    @State var dragOffset: CGFloat = 0.0
    @State var indexOffset: Int = 0
    @State var lastItemPos: Int = 0
    
    @State var players: [String] = ["Bintang", "Teh", "Azuar", "Tono"]
    @State private var dragHasBegun = false // Track if drag gesture has started

    var body: some View {
        VStack(spacing: 8) {
            ForEach(players.indices, id: \.self) { index in
                let curPlayerName = players[index]
                DragListItemView(curPlayerName, Color.singGreen)
                    .gesture(
                        LongPressGesture(minimumDuration: 0.5)
                            .onEnded { _ in
                                isDragging = true
                                draggedIndex = index
                                lastItemPos = index
                                dragHasBegun = false // Reset drag tracking
                                
                                // Start a delay to reset isDragging if no drag occurs
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                                    print("WHATTT DEHEL")
//                                    if isDragging && !dragHasBegun {
//                                        print("WHATTT DEHEL ???")
//                                        isDragging = false // Reset if no drag starts
//                                    }
//                                }
                            }
                            .sequenced(before: DragGesture(minimumDistance: 0))
                            .onChanged { value in
                                switch value {
                                case .second(true, let dragValue):
                                    dragOffset = dragValue?.translation.height ?? .zero
                                    indexOffset = Int(dragOffset / 88)
                                    
                                    if index + indexOffset != lastItemPos {
                                        withAnimation {
                                            players.insert(players.remove(at: lastItemPos), at: draggedIndex + indexOffset)
                                        }
                                        lastItemPos = draggedIndex + indexOffset
                                    }
                                default:
                                    break
                                }
                            }
                            .onEnded { val in
                                switch val {
                                case .second(true, _):
                                    isDragging = false
                                default:
                                    isDragging = false
                                }
                            }
                    )
                    .animation(.spring(), value: isDragging)
            }
        }
        .padding(.top, 8)
        .overlay(alignment: .top) {
            if isDragging {
                DragListItemView(players[lastItemPos], Color.green)
                    .position(x: 125, y: CGFloat((draggedIndex + 1) * 88) - 40.0 + dragOffset)
            }
        }
    }
}

#Preview {
    BintangDragDropView()
}
