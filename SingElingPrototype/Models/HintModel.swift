//
//  HintModel.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 27/10/24.
//

import Foundation

struct HintModel {
    let userRole: UserRole
    let readerName: String?
    
    var text: String {
         switch userRole {
         case .pembacaView:
             return "Bacakan kartu ini kepada \(readerName ?? "Pengguna")!"
         case .penebakView:
             return "Dengar, lalu Tebak Dan\nUrutkan Kartu Berikut Sesuai\nIndex Ketidaksopanan!"
         case .bystanderView:
             return "Dengarkan Dan Pantau Gerakan Kawanmu! Ini Akan Membantumu!"
         case .mainView:
             return "Gabung ruang bermain temanmu atau buat ruang bermain Baru"
         case .createRoomView:
             return "Bagikan kode ruangan dan mulai bermain setelah teman-temanmu bergabung!"
         case .joinRoomView:
             return "Pemilik ruangan akan memulai setelah semua teman bergabung!"
         case .randomTurnView:
             return "Susun urutan giliran main sesuai kesepakatan dengan geser dan \nlepas, santai aja!"
         }
     }
     
    
     var imageName: String {
         switch userRole {
         case .pembacaView:
             return "fluent-emoji_speaking-head"
         case .penebakView:
             return "heroicons-solid_question-mark-circle"
         case .bystanderView:
             return "basil_eye-solid"
         case .mainView:
             return "heroicons-solid_question-mark-circle"
         case .createRoomView:
             return "heroicons-solid_question-mark-circle"
         case .joinRoomView:
             return "heroicons-solid_question-mark-circle"
         case .randomTurnView:
             return "heroicons-solid_question-mark-circle"
         }
     }
    
}

