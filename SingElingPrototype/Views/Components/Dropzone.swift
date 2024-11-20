//
//  Dropzone.swift
//  SingElingPrototype
//
//  Created by Bintang Anandhiya on 24/10/24.
//

import SwiftUI

struct Dropzone: View {
    var width: CGFloat
    var height: CGFloat
    var lineWidth: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(.white.opacity(0.3))
            .stroke(.singElingBlack, style: StrokeStyle(lineWidth: lineWidth,dash: [17],dashPhase: 9))
            .frame(width: width, height: height)
            
    }
}

#Preview {
    Dropzone(width: 30, height: 300, lineWidth: 4)
}
