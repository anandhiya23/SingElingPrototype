//
//  JoinRoomView.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 04/11/24.
//

import SwiftUI
struct GuestJoinRoomView: View {
    @EnvironmentObject var gameManager: GameManager
    @State private var selectedImages: [RoomIconModel?] = Array(repeating: nil, count: 4)
    
    var body: some View {
        ZStack {
            Image("Tikar Cream")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                StatementRoomComponent(width: 300, roomCondition: gameManager.isCodeValidated ? .joinRoomConditionSuccess : .joinRoomCondition)
                    .padding(.top, 50)
                    .padding(.bottom, 50)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 4), spacing: 20) {
                    ForEach(0..<4, id: \.self) { index in
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 3)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(selectedImages[index] != nil ? selectedImages[index]!.color.toColor() : Color.clear) // Menggunakan warna berdasarkan gambar
                                )
                                .frame(width: 80, height: 80)
                            
                            if let iconModel = selectedImages[index] {
                                let iconName = iconModel.iconName
                                Image(iconName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                            }
                        }
                    }
                }

                VStack{
                    CodeRoomComponent { selectedColor, selectedImageName in
                        if let emptySlot = selectedImages.firstIndex(where: { $0 == nil }) {
                            
                            if let selectedRoomIconID = roomIcons.firstIndex(where: { $0.iconName == selectedImageName }) {
                                gameManager.guestRoomCode.append(selectedRoomIconID)
                                selectedImages[emptySlot] = roomIcons[selectedRoomIconID]
                            }
                        }
                    }
                }
                .frame(height: 200)
                .padding(.top,20)
                
                HStack{
                    ButtonComponent(
                        buttonModel: ButtonModel(button: .hapus), width: 164,
                        height: 64,
                        isButtonEnabled: .constant(true),
                        action: {
                            gameManager.guestRoomCode = []
                            selectedImages = Array(repeating: nil, count: 4)
                        }
                    )
                    
                    ButtonComponent(buttonModel: ButtonModel(button: .lanjut), width: 164, height: 64, isButtonEnabled: .constant(true)){
                        if !selectedImages.contains(where: {$0 == nil}) {
                            let numberString = gameManager.guestRoomCode.map { String($0) }.joined(separator: ",")
                            gameManager.initGuest(myUsername: gameManager.myUsername, discoveryInfo: ["code" : numberString])
                            gameManager.curView = 5
                        }
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}


#Preview {
    GuestJoinRoomView()
        .environmentObject(GameManager())
}
