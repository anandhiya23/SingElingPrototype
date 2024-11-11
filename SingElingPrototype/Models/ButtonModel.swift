//
//  ButtonModel.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 10/11/24.
//

import Foundation

enum ButtonCondition{
    case bergabung
    case lanjut
    case main
    case mauLihat
    case menuUtama
    case kunci
}

struct ButtonModel{
    var button: ButtonCondition
    
    var buttonText: String{
        switch button {
        case .bergabung:
            return "Bergabung!"
        case .lanjut:
            return "Lanjut!"
        case .main:
            return "Main!"
        case .mauLihat:
            return "Mau Lihat!"
        case .menuUtama:
            return "Menu Utama"
        case .kunci:
            return "Kunci"
        }
    }
    
    var imageName: String{
        switch button{
        case .bergabung:
            return "bi_hand-thumbs-up-fill"
        case .lanjut:
            return "noto-v1_footprints"
        case .main:
            return "icon-park-solid_fireworks"
        case .mauLihat:
            return "icon-park-solid_fireworks"
        case .menuUtama:
            return "ph_game-controller-duotone"
        case .kunci:
            return "ooui_key"
        }
    }
}
