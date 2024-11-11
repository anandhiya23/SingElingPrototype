//
//  test.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 07/11/24.
//

import SwiftUI

struct test: View {
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.singElingZ90)
            
            Image("UpPatternSeedCard")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .opacity(100)
        }
    }
}

#Preview {
    test()
}
