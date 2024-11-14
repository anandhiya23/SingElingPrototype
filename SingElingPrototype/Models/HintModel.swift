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
             return "Bacakan Kartu Ini\nKepada \(readerName ?? "penebak")!"
         case .penebakView:
             return "Dengar dan Tebak\nUrutan Kartu!"
         case .bystanderView:
             return "Dengar dan Pantau\nGerakan Kawanmu!"
         case .mainView:
             return "Buat ruang bermain baru atau \ngabung ruang temanmu!"
         case .createRoomView:
             return "Bagikan kode ini kepada teman -\ntemanmu untuk bergabung!"
         case .joinRoomView:
             return "Pemilik ruangan akan memulai \nsetelah semua teman bergabung!"
         case .randomTurnView:
             return "Susun urutan giliran main \ndengan geser dan lepas!"
         }
     }
     
    
     var imageName: String? {
         switch userRole {
         case .pembacaView, .penebakView, .bystanderView:
             return nil
         case .mainView:
             return "fluent_door-arrow-right-28-filled"
         case .createRoomView:
             return "game-icons_puzzle"
         case .joinRoomView:
             return "ri_hourglass-fill"
         case .randomTurnView:
             return "lucide_list-ordered"
         }
     }
}
