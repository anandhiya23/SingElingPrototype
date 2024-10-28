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
         case .pembaca:
             return "Bacakan kartu ini kepada \(readerName ?? "Pengguna")!"
         case .penebak:
             return "Dengar, lalu Tebak Dan\nUrutkan Kartu Berikut Sesuai\nKetidaksopanan!"
         case .bystander:
             return "Dengarkan Dan Pantau Gerakan Kawanmu! Ini Akan Membantumu!"
         }
     }
     
    
     var imageName: String {
         switch userRole {
         case .pembaca:
             return "fluent-emoji_speaking-head"
         case .penebak:
             return "heroicons-solid_question-mark-circle"
         case .bystander:
             return "basil_eye-solid"
         }
     }
}

