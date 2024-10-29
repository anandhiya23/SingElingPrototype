//
//  Jempol.swift
//  SingElingPrototype
//
//  Created by Lazuardhi Imani Ahfar on 24/10/24.
//

import SwiftUI

struct Jempol: View {
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        Image("Jempol")
            .resizable()
            .frame(width: width, height: height)
    }
}

#Preview {
    Jempol(width: 65, height: 95)
}
