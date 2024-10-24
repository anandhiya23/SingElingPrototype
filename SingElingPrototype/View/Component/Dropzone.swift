//
//  Dropzone.swift
//  SingElingPrototype
//
//  Created by Bintang Anandhiya on 24/10/24.
//

import SwiftUI

struct Dropzone: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(.white.opacity(0.3))
            .stroke(.gray, style: StrokeStyle(lineWidth: 4,dash: [17],dashPhase: 9))
            .frame(width: 30, height: 300)
            
    }
}

#Preview {
    Dropzone()
}
