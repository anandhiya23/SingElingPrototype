//
//  JoinRoomView.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 04/11/24.
//

import SwiftUI


struct JoinRoomView: View {
    @EnvironmentObject var gameManager: GameManager
    @State private var selectedImages: [RoomIconModel?] = Array(repeating: nil, count: 4) // Menyimpan gambar yang dipilih
    @Binding var curView: Int
    
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
                        if let selectedImage = roomIcons.first(where: { $0.iconName == selectedImageName }) {
                            // Isi slot kosong dengan RoomIconModel yang dipilih
                            selectedImages[emptySlot] = selectedImage
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
                            print("Button tapped")
                            
                            // Pastikan semua slot sudah terisi
                            if !selectedImages.contains(where: { $0 == nil }) {
                                print("Selected images: \(selectedImages)")  // Debugging
                                
                                // Proses input identifiers
                                let inputIdentifiers = selectedImages.compactMap { iconModel -> Int? in
                                    // Pastikan iconModel bukan nil
                                    guard let iconModel = iconModel else {
                                        print("No image selected.") // Debugging
                                        return nil
                                    }
                                    
                                    // Dapatkan identifier berdasarkan iconID yang sudah ada di RoomIconModel
                                    return gameManager.getIdentifier(for: iconModel.iconID)
                                }

                                print("Input identifiers: \(inputIdentifiers)")  // Debugging
                                
                                // Set guest input identifiers
                                gameManager.setGuestInputIdentifiers(inputIdentifiers)
                                
                                // Validasi input identifiers
                                let isValid = gameManager.validateGuestCode()
                                gameManager.isCodeValidated = isValid
                                print("Validation result: \(isValid)")

                                if isValid {
                                    curView = 6
                                    print("curView set to \(curView)")
                                } else {
                                    print("Code validation failed.")
                                    curView = 7
                                }
                            } else {
                                print("Complete all code inputs.") // Ini muncul jika ada slot gambar yang belum dipilih
                            }
                        }, buttonModel: ButtonModel(button: .lanjut))
                    )
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
}


struct JoinRoomView_Previews: PreviewProvider {
    @State static var previewCurView = 0  // Local @State variable for preview
    
    static var previews: some View {
        JoinRoomView(curView: $previewCurView)  // Pass as binding
            .environmentObject(GameManager(username: "Host"))
    }
}
