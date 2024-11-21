//
//  StatementRoomComponent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 02/11/24.
//

import SwiftUI

struct StatementRoomComponent: View {
    var width: CGFloat
    var roomCondition: RoomCondition

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.backgroundCream)
                .frame(width: width * 0.83, height: roomCondition == .joinRoomConditionFailed ? width * 0.40 : width * 0.25)

            VStack(alignment: .center, spacing: 4) {
                if roomCondition == .createRoomCondition {
                    HStack(spacing: 10) {
                        Text("Ruang")
                            .font(.custom("Skrapbook", size: width * 0.1))
                            .foregroundColor(Color.singElingBlack)

                        highlightedText("BERMAIN", fontSize: width * 0.085)
                    }
                    Text("sudah terbuat!")
                        .font(.custom("Skrapbook", size: width * 0.1))
                        .foregroundColor(Color.singElingBlack)
                } else if roomCondition == .joinRoomCondition {
                    Text("Gabung ruang")
                        .font(.custom("Skrapbook", size: width * 0.1))
                        .foregroundColor(Color.singElingBlack)
                    
                    HStack(spacing: 3) {
                        highlightedText("BERMAIN", fontSize: width * 0.085)
                        Text("temanmu!")
                            .font(.custom("Skrapbook", size: width * 0.1))
                            .foregroundColor(Color.singElingBlack)
                    }
                } else if roomCondition == .joinRoomConditionSuccess {
                    Text("Berhasil bergabung")
                        .font(.custom("Skrapbook", size: width * 0.1))
                        .foregroundColor(Color.singElingBlack)
                    
                    HStack(spacing: 7) {
                        Text("ke ruang")
                            .font(.custom("Skrapbook", size: width * 0.1))
                            .foregroundColor(Color.singElingBlack)
                        highlightedText("BERMAIN", fontSize: width * 0.085)
                        Text("!")
                            .font(.custom("Skrapbook", size: width * 0.1))
                            .foregroundColor(Color.singElingBlack)
                    }
                } else if roomCondition == .joinRoomConditionFailed {
                    Text("Tidak berhasil")
                        .font(.custom("Skrapbook", size: width * 0.1))
                        .foregroundColor(Color.singElingBlack)
                    Text("bergabung")
                        .font(.custom("Skrapbook", size: width * 0.1))
                        .foregroundColor(Color.singElingBlack)
                    HStack(spacing: 7) {
                        Text("ke ruang")
                            .font(.custom("Skrapbook", size: width * 0.1))
                            .foregroundColor(Color.singElingBlack)

                        highlightedText("BERMAIN", fontSize: width * 0.085)
                        Text("!")
                            .font(.custom("Skrapbook", size: width * 0.1))
                            .foregroundColor(Color.singElingBlack)
                    }
                }
            }
            .padding(.horizontal, 1)
            .multilineTextAlignment(.leading)
        }
    }
    
    private func highlightedText(_ text: String, fontSize: CGFloat) -> some View {
        ZStack {
            Text(text)
                .font(.custom("Skrapbook", size: fontSize))
                .foregroundColor(Color.singElingBlack)
                .tracking(2)
                .offset(x: -1, y: -1)
            Text(text)
                .font(.custom("Skrapbook", size: fontSize))
                .foregroundColor(Color.singElingBlack)
                .tracking(2)
                .offset(x: 1, y: -1)
            Text(text)
                .font(.custom("Skrapbook", size: fontSize))
                .foregroundColor(Color.singElingBlack)
                .tracking(2)
                .offset(x: -1, y: 1)
            Text(text)
                .font(.custom("Skrapbook", size: fontSize))
                .foregroundColor(Color.singElingBlack)
                .tracking(2)
                .offset(x: 1, y: 1)
            Text(text)
                .font(.custom("Skrapbook", size: fontSize))
                .foregroundColor(.singElingPG50)
                .tracking(2)
        }
    }
}

#Preview {
    StatementRoomComponent(width: 300, roomCondition: .joinRoomConditionFailed)
}
