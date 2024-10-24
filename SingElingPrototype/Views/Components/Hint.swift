//
//  HintView.swift
//  SingElingPrototype
//
//  Created by Bintang Anandhiya on 24/10/24.
//

import SwiftUI

struct Hint: View {
    var body: some View {
        HStack{
            Image(.kepalaTeriak)
                .resizable()
                .scaledToFit()
                .frame(width: 40)
            Text("Dengarkan Dan Pantau Gerakan\nKawanmu! Ini Akan Membantumu!")
                .multilineTextAlignment(.center)
                .font(Font.custom("skrapbook", size: 20))
        }
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 227/255, green: 187/255, blue: 166/255))
        }
        
    }
}

#Preview {
    Hint()
}
