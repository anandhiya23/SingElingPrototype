//
//  CardThrowView.swift
//  SingElingPrototype
//
//  Created by Lazuardhi Imani Ahfar on 18/11/24.
//

import SwiftUI

struct CardThrowView: View {
    var announcementRole: Bool = false
    var cardText: String = "test card"
    var cardNum: Int = 1
    var backgroundImage: String = "Card1"
    var vw: CGFloat = 402
    var vh: CGFloat = 874
    
    var vmode: Int{
        2
    }
    var midCardY: CGFloat {
        switch vmode {
        case 0:
            return 55 / 100 * vh
        case 1:
            return 33 / 100 * vh
        default:
            return 64 / 100 * vh
        }
    }
    
    var body: some View {
        ZStack{
            Image("GarbageBehind")
            
            CardComponent(width: 220, text: cardText, indexNum: cardNum, backgroundImage: backgroundImage)
                .position(x:1/2*vw, y: announcementRole ? (vmode == 2 ? midCardY : 2*vh) : (vmode == 2 ? midCardY : 2*vh))
                .animation(.bouncy.speed(1.4), value: announcementRole)
        }
    }
}

#Preview {
    CardThrowView()
}
