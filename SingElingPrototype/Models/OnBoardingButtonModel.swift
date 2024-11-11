//
//  OnBoardingButtonModel.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 11/11/24.
//

import Foundation

enum OnBoardingButton{
    case siapLanjut
    case lanjut
    case udahSiap
    case buktikan
}

struct OnBoardingButtonModel{
    var onBoardingButton: OnBoardingButton
    
    var buttonText: String{
        switch onBoardingButton {
        case .siapLanjut: 
            return "Siap Lanjut!"
        case .lanjut:
            return "Lanjut!"
        case .udahSiap:
            return "Udah Siap!"
        case .buktikan:
            return "Buktikan!"
        }
    }
}
