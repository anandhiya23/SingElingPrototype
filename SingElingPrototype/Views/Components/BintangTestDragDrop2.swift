//
//  BintangDragDropView.swift
//  SingElingPrototype
//
//  Created by Bintang Anandhiya on 28/10/24.
//

import SwiftUI
import Foundation

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

struct TempPlayer {
    var name: String
    var color: Color
}

struct BintangDragDropView2: View {
    @EnvironmentObject var gameManager: GameManager
    @State var isDragging = false
    @State var draggedIndex = 0
    @State var dragOffset: CGFloat = 0.0
    @State var indexOffset: Int = 0
    @State var lastItemPos: Int = 0
    @State var tempGetObject: Player = Player()
    var body: some View {
        ZStack{
            Image("Tikar Cream")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack{
                Spacer()
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.singElingLC10)
                    .frame(width: 340, height: 80)
                    .overlay {
                        HStack{
                            Text("Ini giliran mainmu!")
                                .font(.custom("skrapbook", size: 30))
                                .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal,10)
                    }
//                RoundedRectangle(cornerRadius: 12)
//                    .fill(Color.singElingLC10)
//                    .frame(width: 340, height: 80)
//                    .overlay {
//                        HStack{
//                            Image("lucide_list-ordered")
//                            Text("Susun urutan giliran main sesuai dengan geser dan lepas!")
//                                .font(.custom("skrapbook", size: 18))
//                                .multilineTextAlignment(.center)
//                        }
//                        .padding(.horizontal,10)
//                    }
                
                HStack(alignment: .top){
                    VStack{
                        ForEach(1...4, id: \.self){ index in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.singElingSB10)
                                .strokeBorder(Color.black,style: StrokeStyle(lineWidth: 3))
                                .frame(width: 80, height: 80)
                                .overlay {
                                    Text("\(index)")
                                        .font(.custom("skrapbook", size: 40))
                                }
                            
                        }
                    }
                    .padding(.top, 8)
                    
                    VStack(spacing: 8) {
                        ForEach(0..<gameManager.gameState.players.count, id: \.self) { index in
                            
                                let curPlayerName = gameManager.gameState.players[index].name
                                DragListItemView(curPlayerName, gameManager.gameState.players[index].color.toColor())
                                    .allowsHitTesting(gameManager.isHost)
                                    .padding(.top, lastItemPos == index && isDragging ? 88 : 0)
                                    .padding(.bottom, lastItemPos - 1 == index && isDragging && gameManager.gameState.players.count == lastItemPos ? 88 : 0)
                                    .simultaneousGesture(
                                        LongPressGesture(minimumDuration: 0.05)
                                            .onEnded { success in
                                                if success {
                                                    isDragging = true
                                                    draggedIndex = index
                                                    lastItemPos = index
                                                    tempGetObject = gameManager.gameState.players.remove(at: lastItemPos)
                                                }
                                            }
                                    )
                            
                        }
                    }
                    .allowsHitTesting(gameManager.isHost)
                    .simultaneousGesture(DragGesture(minimumDistance: 0)
                        .onChanged { dragValue in
                            if isDragging{
                                dragOffset = dragValue.translation.height
                                indexOffset = Int(dragOffset / 88.0)
                                let dropIndex = (draggedIndex + indexOffset).clamped(to: 0...gameManager.gameState.players.count)
                                if dropIndex != lastItemPos {
                                    withAnimation(.bouncy.speed(2)){
                                        lastItemPos = dropIndex
                                    }
                                }
                            }
                        }
                        .onEnded { val in
                            if isDragging{
                                gameManager.gameState.players.insert(tempGetObject, at: lastItemPos)
                                isDragging = false
                            }
                        }
                    )
                    .padding(.top, 8)
                    .overlay(alignment: .top) {
                        if isDragging {
                            DragListItemView(tempGetObject.name, tempGetObject.color.toColor())
                                .scaleEffect(1.07)
                                .background{
                                    RoundedRectangle(cornerRadius: 10)
                                        .shadow(radius: 8, y: 5)
                                }
                                .position(x: 125, y: CGFloat((draggedIndex + 1) * 88) - 40.0 + dragOffset)
                        }
                    }
                }
                Spacer()
                .padding(.bottom, 160)
                .frame(height: 140)
            }
        }
        .ignoresSafeArea()
        .onChange(of: gameManager.gameState.isPlaying) { oldValue, newValue in
            if newValue == true{
                gameManager.curView = 4
            }
        }
    }
}

#Preview {
    @Previewable @State var gameManager = GameManager()
    
    BintangDragDropView2()
        .environmentObject(gameManager)
        .onAppear{
            gameManager.gameState.players.append(Player())
            gameManager.gameState.players.append(Player())
            gameManager.gameState.players.append(Player())
        }
}
