//
//  JoinRoomView.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 04/11/24.
//

import SwiftUI

//struct JoinRoomView: View {
//    @State private var selectedColors: [Color] = Array(repeating: Color.white, count: 4)
//       @State private var selectedImages: [String?] = Array(repeating: nil, count: 4)
//
//    var body: some View {
//        ZStack{
//            Rectangle()
//                .fill(Color.singElingZ50)
//                .ignoresSafeArea()
//
//            VStack {
//                StatementRoomComponent(width: 300, roomCondition: .joinRoomCondition)
//                    .padding(.top, 50)
//                    .padding(.bottom, 50)
//                // LazyVGrid untuk menampilkan pilihan user
//                let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 4)
//                LazyVGrid(columns: columns, spacing: 20) {
//                    ForEach(0..<4, id: \.self) { index in
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 15)
//                                .stroke(Color.black, lineWidth: 3)
//                                .background(
//                                    RoundedRectangle(cornerRadius: 15)
//                                        .fill(selectedColors[index]) // Warna dari pilihan user
//                                )
//                                .frame(width: 80, height: 80)
//
//                            // Jika ada gambar yang dipilih, tampilkan
//                            if let imageName = selectedImages[index] {
//                                 Image(imageName)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 40, height: 40)
//                            }
//                        }
//                    }
//                }
//
//                // CodeRoomComponent untuk memilih warna dan gambar
//                CodeRoomComponent { selectedColor, selectedImage in
//                    // Cari slot kosong untuk mengisi gambar dan warna yang dipilih
//                    if let emptySlot = selectedColors.firstIndex(of: Color.white) {
//                        selectedColors[emptySlot] = selectedColor
//                        selectedImages[emptySlot] = selectedImage
//                    }
//                }
//                .padding(.top, 50)
//
//                Spacer()
//                Rectangle()
//                    .fill(Color.singElingLC50)
//                    .frame(height: 130)
//                    .overlay(
//                        SetujuButton(width: 164, height: 64, text: "Setuju!", imageName: "bi_hand-thumbs-up-fill") {
//                            print("Setuju button pressed!")
//                        }
//                    )
//            }
//            .ignoresSafeArea(edges: .bottom)
//        }
//    }
//}

//struct JoinRoomView: View {
//    @EnvironmentObject var gameManager: GameManager
//    @State private var selectedColors: [Color] = Array(repeating: Color.white, count: 4)
//    @State private var selectedImages: [String?] = Array(repeating: nil, count: 4)
//    @Binding var curView: Int
//    
//    var body: some View {
//        ZStack {
//            Rectangle()
//                .fill(Color.singElingZ50)
//                .ignoresSafeArea()
//            
//            VStack {
//                // Change roomCondition based on validation status
//                StatementRoomComponent(width: 300, roomCondition: gameManager.isCodeValidated ? .joinRoomConditionSuccess : .joinRoomCondition)
//                    .padding(.top, 50)
//                    .padding(.bottom, 50)
//                
//                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 4), spacing: 20) {
//                    ForEach(0..<4, id: \.self) { index in
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 15)
//                                .stroke(Color.black, lineWidth: 3)
//                                .background(
//                                    RoundedRectangle(cornerRadius: 15)
//                                        .fill(selectedColors[index])
//                                )
//                                .frame(width: 80, height: 80)
//                            
//                            if let imageName = selectedImages[index] {
//                                Image(imageName)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 40, height: 40)
//                            }
//                        }
//                    }
//                }
//                
//                CodeRoomComponent { selectedColor, selectedImage in
//                    if let emptySlot = selectedColors.firstIndex(of: Color.white) {
//                        selectedColors[emptySlot] = selectedColor
//                        selectedImages[emptySlot] = selectedImage
//                    }
//                }
//                .padding(.top, 50)
//                
//                Spacer()
//                Rectangle()
//                    .fill(Color.singElingLC50)
//                    .frame(height: 130)
//                    .overlay(
//                        SetujuButton(width: 164, height: 64, text: "Setuju!", imageName: "bi_hand-thumbs-up-fill") {
//                            print("Setuju button tapped.")
//                            //                            if !selectedColors.contains(Color.white),
//                            //                               !selectedImages.contains(where: { $0 == nil }) {
//                            ////                                if gameManager.validateGuestCode(inputColors: selectedColors, inputImages: selectedImages.compactMap { $0 }) {
//                            ////                                    gameManager.isCodeValidated = true
//                            ////                                    curView = 6  // Pindah ke view berikutnya jika validasi berhasil
//                            ////                                    print("curView set to \(curView)")
//                            ////                                } else {
//                            ////                                    print("Code validation failed.")
//                            ////                                }
//                            ////                            } else {
//                            ////                                print("Complete all code inputs.")
//                            ////                            }
//                            //                                // Validasi kode guest
//                            //                                                                let isValid = gameManager.validateGuestCode(inputColors: selectedColors, inputImages: selectedImages.compactMap { $0 })
//                            //                                                                gameManager.isCodeValidated = isValid
//                            //                                                                if isValid {
//                            //                                                                    curView = 6  // Jika validasi berhasil, pindah view
//                            //                                                                    print("curView set to \(curView)")
//                            //                                                                } else {
//                            //                                                                    print("Code validation failed.")
//                            //                                                                }
//                            //                                                            } else {
//                            //                                                                print("Complete all code inputs.")
//                            //                                                            }
//                            
//                            //validasi sementara
//                            if !selectedColors.contains(Color.white),
//                               !selectedImages.contains(where: { $0 == nil }) {
//                                let isValid = gameManager.validateGuestCode()
//                                gameManager.isCodeValidated = isValid
//                                if isValid {
//                                    curView = 6  
//                                    print("curView set to \(curView)")
//                                } else {
//                                    print("Code validation failed.")
//                                }
//                            } else {
//                                print("Complete all code inputs.")
//                            }
//                        }
//                    )
//            }
//            .ignoresSafeArea(edges: .bottom)
//            .onAppear() {
////                gameManager.gameState.roomColors = [.singElingLC10, .singElingLC50, .singElingZ50, .singElingPG50]
//                gameManager.gameState.roomImages = ["tree", "flower", "mask", "sword"]
//            }
//        }
//    }
//}
//
//
////#Preview {
////    JoinRoomView(curView: .constant(0))
////        .environmentObject(GameManager(username: "Host"))
////}
//
//struct JoinRoomView_Previews: PreviewProvider {
//    @State static var previewCurView = 0  // Local @State variable for preview
//    
//    static var previews: some View {
//        JoinRoomView(curView: $previewCurView)  // Pass as binding
//            .environmentObject(GameManager(username: "Host"))
//    }
//}

//struct JoinRoomView: View {
//    @EnvironmentObject var gameManager: GameManager
//    @State private var selectedColors: [Color] = Array(repeating: Color.white, count: 4)
////    @State private var selectedImages: [String?] = Array(repeating: nil, count: 4)
//    @State private var selectedImages: [RoomIconModel?] = Array(repeating: nil, count: 4)
//    
//    @Binding var curView: Int
//
//    var body: some View {
//        ZStack {
//            Rectangle()
//                .fill(Color.singElingZ50)
//                .ignoresSafeArea()
//            
//            VStack {
//                StatementRoomComponent(width: 300, roomCondition: gameManager.isCodeValidated ? .joinRoomConditionSuccess : .joinRoomCondition)
//                    .padding(.top, 50)
//                    .padding(.bottom, 50)
//                
//                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 4), spacing: 20) {
//                    ForEach(0..<4, id: \.self) { index in
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 15)
//                                .stroke(Color.black, lineWidth: 3)
//                                .background(
//                                    RoundedRectangle(cornerRadius: 15)
//                                        .fill(selectedColors[index])
//                                )
//                                .frame(width: 80, height: 80)
//                            
////                            if let imageName = selectedImages[index] {
////                                Image(imageName)
////                                    .resizable()
////                                    .scaledToFit()
////                                    .frame(width: 40, height: 40)
////                            }
//                            if let iconModel = selectedImages[index] {
//                                // Gunakan iconID untuk mendapatkan nama gambar melalui IconIdentifier
//                                let iconName = IconIdentifier(rawValue: iconModel.iconID)?.iconName() ?? "defaultIcon"
//                                Image(iconName) // Gunakan iconName untuk mendapatkan gambar
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 40, height: 40)
//                            }
//                        }
//                    }
//                }
//                
////                CodeRoomComponent { selectedColor, selectedImage in
////                    if let emptySlot = selectedColors.firstIndex(of: Color.white) {
////                        selectedColors[emptySlot] = selectedColor
////                        selectedImages[emptySlot] = selectedImage
////                    }
////                }
//                // Asumsikan selectedImage adalah String (misalnya iconName)
//                // Kita perlu mencari RoomIconModel yang sesuai berdasarkan iconName atau iconID.
////                CodeRoomComponent { selectedColor, selectedImageName in
////                    if let emptySlot = selectedImages.firstIndex(where: { $0 == nil }) {
////                        // Mencari RoomIconModel yang sesuai dengan selectedImageName (misalnya nama gambar)
////                        if let selectedImage = roomIcons.first(where: { $0.iconName == selectedImageName }) {
////                            // Jika ditemukan, simpan RoomIconModel ke dalam selectedImages
////                            selectedImages[emptySlot] = selectedImage
////                        }
////                    }
////                }
//
//                CodeRoomComponent { selectedColor, selectedImageName in
//                    if let emptySlot = selectedImages.firstIndex(where: { $0 == nil }) {
//                        // Cari RoomIconModel yang sesuai dengan nama gambar (selectedImageName)
//                        if let selectedImage = roomIcons.first(where: { $0.iconName == selectedImageName }) {
//                            // Jika ditemukan, simpan RoomIconModel ke dalam selectedImages
//                            selectedImages[emptySlot] = selectedImage
//                            
//                            // Jika Anda hanya ingin menampilkan warna sesuai gambar yang dipilih (untuk UI)
//                            selectedColors[emptySlot] = selectedImage.color
//                        }
//                    }
//                }
//
//                .padding(.top, 50)
//                
//                Spacer()
//                 Rectangle()
//                     .fill(Color.singElingLC50)
//                     .frame(height: 130)
//                     .overlay(
//                         SetujuButton(width: 164, height: 64, text: "Setuju!", imageName: "bi_hand-thumbs-up-fill") {
//                             print("Setuju button tapped.")
//                             
////                             if !selectedColors.contains(Color.white), !selectedImages.contains(where: { $0 == nil }) {
////                                 let inputIdentifiers = selectedImages.compactMap { iconModel -> Int? in
////                                     // Memastikan iconModel bukan nil
////                                     guard let iconModel = iconModel else {
////                                         print("No image selected.")
////                                         return nil // Jika iconModel nil, abaikan elemen ini
////                                     }
////                                     
////                                     // Dapatkan identifier berdasarkan iconModel
////                                     let identifier = gameManager.getIdentifier(for: iconModel.iconID) // Panggil fungsi dengan objek RoomIconModel
////                                     
////                                     // Jika identifier tidak ditemukan, log pesan
////                                     if identifier == nil {
////                                         print("No identifier found for image: \(iconModel.iconID)") // Debugging menggunakan iconName
////                                     }
////                                     
////                                     return identifier // Return identifier jika ditemukan, atau nil jika tidak ada identifier
////                                 }
////
////                                 print("Input identifiers: \(inputIdentifiers)")
////                                 // Set guest input identifiers
////                                 gameManager.setGuestInputIdentifiers(inputIdentifiers)
////                                 
////                                 // Validate the guest input identifiers
////                                 let isValid = gameManager.validateGuestCode()
////                                 gameManager.isCodeValidated = isValid
////                                 print("Validation result: \(isValid)")
////                                 
////                                 if isValid {
////                                     curView = 6
////                                     print("curView set to \(curView)")
////                                 } else {
////                                     print("Code validation failed.")
////                                     curView = 7
////                                 }
////                             } else {
////                                 print("Complete all code inputs.")
////                             }
//                             if !selectedColors.contains(Color.white), !selectedImages.contains(where: { $0 == nil }) {
//                                 print("Selected colors: \(selectedColors)")  // Debugging
//                                 print("Selected images: \(selectedImages)")  // Debugging
//                                 
//                                 // Proses input identifiers
//                                 let inputIdentifiers = selectedImages.compactMap { iconModel -> Int? in
//                                     // Memastikan iconModel bukan nil
//                                     guard let iconModel = iconModel else {
//                                         print("No image selected.") // Debugging
//                                         return nil
//                                     }
//
//                                     // Dapatkan identifier berdasarkan iconModel
//                                     let identifier = gameManager.getIdentifier(for: iconModel.iconID) // Panggil fungsi dengan objek RoomIconModel
//
//                                     // Jika identifier tidak ditemukan, log pesan
//                                     if identifier == nil {
//                                         print("No identifier found for image: \(iconModel.iconID)") // Debugging
//                                     }
//
//                                     return identifier // Return identifier jika ditemukan, atau nil jika tidak ada identifier
//                                 }
//
//                                 print("Input identifiers: \(inputIdentifiers)")
//                                 // Set guest input identifiers
//                                 gameManager.setGuestInputIdentifiers(inputIdentifiers)
//                                 
//                                 // Validate the guest input identifiers
//                                 let isValid = gameManager.validateGuestCode()
//                                 gameManager.isCodeValidated = isValid
//                                 print("Validation result: \(isValid)")
//
//                                 if isValid {
//                                     curView = 6
//                                     print("curView set to \(curView)")
//                                 } else {
//                                     print("Code validation failed.")
//                                     curView = 7
//                                 }
//                             } else {
//                                 print("Complete all code inputs.") // Ini muncul jika ada slot warna atau gambar yang belum dipilih
//                             }
//
//                         }
//                     )
//             }
//             .ignoresSafeArea(edges: .bottom)
////             .onAppear {
////                 gameManager.gameState.roomImages = ["tree", "flower", "mask", "sword"]
////             }
//         }
//     }
// }
//
//struct JoinRoomView_Previews: PreviewProvider {
//    @State static var previewCurView = 0  // Local @State variable for preview
//    
//    static var previews: some View {
//        JoinRoomView(curView: $previewCurView)  // Pass as binding
//            .environmentObject(GameManager(username: "Host"))
//    }
//}

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


//struct JoinRoomView_Previews: PreviewProvider {
//    @State static var previewCurView = 0  // Local @State variable for preview
//    
//    static var previews: some View {
//        JoinRoomView(curView: $previewCurView)  // Pass as binding
//            .environmentObject(GameManager(username: "Host"))
//    }
//}
