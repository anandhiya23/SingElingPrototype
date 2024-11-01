//
//  JoinRoomView.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 01/11/24.
//

import SwiftUI

struct JoinRoomView: View {
    @StateObject private var gameManager = GameManager(username: String(UUID().uuidString.prefix(6)))
    @Binding var curView: Int
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.singElingZ50)
                .ignoresSafeArea()
            VStack{
                Text("Sing \nEling")
                    .multilineTextAlignment(.center)
                    .font(.custom("Skrapbook", size: 85))
                HintComponent(hintModel: HintModel(userRole: .mainView, readerName: ""), width: 300)
                    .padding()
                VStack {
                                    RoomComponent(curView: $curView, roomModel: RoomModel(typeRoom: .createRoom), width: 200)
                                        .padding()
                                    RoomComponent(curView: $curView, roomModel: RoomModel(typeRoom: .joinRoom), width: 200)
                                }
                            }
                        }
                        .environmentObject(gameManager)
                    }
                }

#Preview {
    @State var curView: Int = 0

    JoinRoomView(curView: $curView)
}
