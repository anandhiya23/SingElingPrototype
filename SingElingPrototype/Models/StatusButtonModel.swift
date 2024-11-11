//
//  StatusButtonModel.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 10/11/24.
//

import Foundation
import SwiftUI

enum StatusButtonCondition{
    case taruh
    case hapus
    case yakin
    case tidak
}

struct StatusButtonModel {
    var statusButton: StatusButtonCondition
    
    var statusButtontext: String{
        switch statusButton {
        case .taruh:
            return "Taruh!"
        case .hapus:
            return "Hapus!"
        case .yakin:
            return "Yakin!"
        case .tidak:
            return "Tidak!"
        }
    }
    
    var imageName: String{
        switch statusButton {
            case .taruh:
            return "bi_hand-thumbs-up-fill"
        case .hapus:
            return "mdi_delete"
        case .yakin:
            return "fa-solid_check"
        case .tidak:
            return "dashicons_no"
        }
    }
    
    var fillColor: Color{
        switch statusButton {
        case .taruh:
            return .singElingZ50
        case .hapus:
            return .singElingLC50
        case .yakin:
            return .singElingZ50
        case .tidak:
            return .singElingLC50
        }
    }
}
