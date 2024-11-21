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
    case mainLagi
    case mauLihat
    case menuUtama
    case kunci
    case yakin
    case tidak
    case hapus
    case taruh
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
        case .mainLagi:
            return "Main Lagi!"
        case .mauLihat:
            return "Mau Lihat!"
        case .menuUtama:
            return "Menu Utama"
        case .kunci:
            return "Kunci"
        case .yakin:
            return "Yakin"
        case .tidak:
            return "Tidak"
        case .hapus:
            return "Hapus"
        case .taruh:
            return "Taruh!"
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
        case .mainLagi:
            return "icon-park-solid_fireworks"
        case .mauLihat:
            return "healthicons_magnifying-glass"
        case .menuUtama:
            return "Home"
        case .kunci:
            return "ooui_key"
        case .yakin:
            return "fa-solid_check"
        case .tidak:
            return "dashicons_no"
        case .hapus:
            return "mdi_delete"
        case .taruh:
            return "bi_hand-thumbs-up-fill"
        }
        
    }
}
