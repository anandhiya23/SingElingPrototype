//
//  SetujuButton.swift
//  SingElingPrototype
//
//  Created by Lazuardhi Imani Ahfar on 24/10/24.
//

import SwiftUI

struct SetujuButton: View {
    var body: some View {
        ZStack{
            HStack{
                Image(systemName: "hand.thumbsup.fill")
                    .resizable()
                    .frame(width: 40, height: 50)
                    
                Spacer()
                
                Text("Setuju!")
                    .font(.custom("Skrapbook", size: 25.6))
            }
            .padding()
        }
        .background(RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(Color(red: 0.39, green: 0.82, blue: 1.0)))
        .frame(width: 164, height: 64)

    }
}

#Preview {
    SetujuButton()
}
