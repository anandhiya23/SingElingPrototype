//
//  HintGameView.swift
//  SingElingPrototype
//
//  Created by Lazuardhi Imani Ahfar on 11/11/24.
//

import SwiftUI

struct HintGameComponent: View {
    var hintModel: HintModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.singCardText) // Background color
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.black, lineWidth: 4) // Border color and width
                )
            HStack{
                Text(hintModel.text)
                    .font(.custom("Skrapbook", size: 16))
                    .foregroundColor(.black)
                Image(systemName: "info.circle.fill")
                    .resizable()
                    .frame(width: 27, height: 27)
                
            }
        }
    }
}

#Preview {
    HintGameComponent(hintModel: HintModel(userRole: .bystanderView, readerName: ""))
}



