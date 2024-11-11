//
//  BackButton.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 10/11/24.


import SwiftUI

struct BackButtonComponent: View {
    var body: some View {
        
        HStack {
            Image("backIcon")
            
            Text("Keluar")
                .font(.custom("Skrapbook", size: 16))
                .foregroundColor(.black)
        }
        .frame(width: 91, height: 32)
        .background(Color.white)
        .cornerRadius(8)
    }
}

#Preview {
    BackButtonComponent()
}
