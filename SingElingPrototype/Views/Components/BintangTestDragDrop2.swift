//
//  BintangDragDropView.swift
//  SingElingPrototype
//
//  Created by Bintang Anandhiya on 28/10/24.
//

import SwiftUI
import Foundation

struct DragListItemView: View {
    var text: String
    var color: Color
    
    init(_ text: String, _ color: Color) {
        self.text = text
        self.color = color
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(color)
            .strokeBorder(Color.black,style: StrokeStyle(lineWidth: 5))
            .frame(width: 250, height: 80)
            .overlay {
                Text(text)
                    .foregroundStyle(.black)
                    .font(.custom("skrapbook", size: 30))
            }
            
    }
}

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
    @State var isDragging = false
    @State var draggedIndex = 0
    @State var dragOffset: CGFloat = 0.0
    @State var indexOffset: Int = 0
    @State var lastItemPos: Int = 0
    @State var tempGetObject: TempPlayer = TempPlayer(name: "", color: Color.red)
    
    @State var players: [TempPlayer] = [
        TempPlayer(name: "Bintang", color: .singElingLC50),
        TempPlayer(name: "Azuar", color: .singElingDSB50),
        TempPlayer(name: "Reyhan", color: .singElingSB50),
        TempPlayer(name: "Kale", color: .singElingZ50)
        ]

    var body: some View {
        ZStack{
            Color.singElingDS50
            VStack{
                Spacer()
                Text("Atur giliran\nMainmu, Yuk!")
                    .font(.custom("skrapbook", size: 40))
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.singElingDS30)
                    .frame(width: 340, height: 80)
                    .overlay {
                        HStack{
                            Image(systemName: "questionmark.circle.fill")
                                .font(.system(size: 40))
                            Text("Susun urutan giliran main sesuai kesepakatan dengan geser dan lepas, santai aja!")
                                .font(.custom("skrapbook", size: 18))
                                .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal,10)
                    }
                
                HStack{
                    VStack{
                        ForEach(1..<5, id: \.self){ index in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.singElingSB10)
                                .strokeBorder(Color.black,style: StrokeStyle(lineWidth: 5))
                                .frame(width: 80, height: 80)
                                .overlay {
                                    Text("\(index)")
                                        .font(.custom("skrapbook", size: 40))
                                }
                            
                        }
                    }
                    .padding(.top, 8)
                    VStack(spacing: 8) {
                        ForEach(players.indices, id: \.self) { index in
                            let curPlayerName = players[index].name
                            DragListItemView(curPlayerName, players[index].color)
                                .padding(.top, lastItemPos == index && isDragging ? 88 : 0)
                                .padding(.bottom, lastItemPos - 1 == index && isDragging && players.count == lastItemPos ? 88 : 0)
                                .simultaneousGesture(
                                    LongPressGesture(minimumDuration: 0.05)
                                        .onEnded { success in
                                            if success{
                                                isDragging = true
                                                draggedIndex = index
                                                lastItemPos = index
                                                tempGetObject = players.remove(at: lastItemPos)
                                            }
                                        }
                                )
                            //                    .animation(.spring(), value: isDragging)
                        }
                    }
                    .simultaneousGesture(DragGesture(minimumDistance: 0)
                        .onChanged { dragValue in
                            if isDragging{
                                dragOffset = dragValue.translation.height
                                indexOffset = Int(dragOffset / 88.0)
                                //                    print("\(draggedIndex) + \(indexOffset)")
                                let dropIndex = (draggedIndex + indexOffset).clamped(to: 0...players.count)
                                if dropIndex != lastItemPos {
                                    withAnimation(.bouncy.speed(2)){
                                        lastItemPos = dropIndex
                                    }
                                }
                            }
                        }
                        .onEnded { val in
                            if isDragging{
                                players.insert(tempGetObject, at: lastItemPos)
                                isDragging = false
                            }
                        }
                    )
                    .padding(.top, 8)
                    .overlay(alignment: .top) {
                        if isDragging {
                            DragListItemView(tempGetObject.name, tempGetObject.color)
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
                ZStack{
                    Color.singElingLC50
                    Button {
                        print("blahaha")
                    } label: {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.singElingDS10)
                            .strokeBorder(Color.black,style: StrokeStyle(lineWidth: 5))
                            .frame(width: 180, height: 80)
                            .overlay {
                                HStack{
                                    Image(systemName: "hand.thumbsup.fill")
                                        .foregroundStyle(.black)
                                        .font(.system(size: 30))
                                    Text("Lanjut!")
                                        .foregroundStyle(.black)
                                        .font(.custom("skrapbook", size: 30))
                                }
                                
                            }
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.singElingDS70)
                                    .strokeBorder(Color.black,style: StrokeStyle(lineWidth: 5))
                                    .padding(.bottom,-10)
                            }
                    }
                }
                .frame(height: 140)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    BintangDragDropView2()
}
