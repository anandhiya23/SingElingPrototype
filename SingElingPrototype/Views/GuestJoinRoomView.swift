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
            Rectangle()
                .fill(Color.singElingZ50)
                .ignoresSafeArea()
            
            VStack {
                StatementRoomComponent(width: 300, roomCondition: gameManager.isCodeValidated ? .joinRoomConditionSuccess : .joinRoomCondition)
                    .padding(.top, 50)
                    .padding(.bottom, 50)
                
                // Menampilkan gambar yang dipilih
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

                CodeRoomComponent { selectedColor, selectedImageName in
                    // Temukan slot kosong
                    if let emptySlot = selectedImages.firstIndex(where: { $0 == nil }) {
                        // Cari RoomIconModel yang sesuai dengan nama gambar yang dipilih
                        
                        if let selectedRoomIconID = roomIcons.firstIndex(where: { $0.iconName == selectedImageName }) {
                            // Isi slot kosong dengan RoomIconModel yang dipilih
                            gameManager.guestRoomCode.append(selectedRoomIconID)
                            selectedImages[emptySlot] = roomIcons[selectedRoomIconID]
                        }
                    }
                }
                .padding(.top, 50)
                
                Spacer()
                Rectangle()
                    .fill(Color.singElingLC50)
                    .frame(height: 130)
                    .overlay(
                        ButtonComponent(width: 164, height: 64, action: {
                            if !selectedImages.contains(where: {$0 == nil}) {
                                let numberString = gameManager.guestRoomCode.map { String($0) }.joined(separator: ",")
                                gameManager.initGuest(myUsername: gameManager.myUsername, discoveryInfo: ["code" : numberString])
                            }
                        }, buttonModel: ButtonModel(button: .lanjut))
                    )
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}


#Preview {
    GuestJoinRoomView()
        .environmentObject(GameManager())
}
