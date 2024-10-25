//
//  CurrentWinnerIndicator.swift
//  SingElingPrototype
//
//  Created by Lazuardhi Imani Ahfar on 24/10/24.
//

import SwiftUI

struct CurrentWinnerIndicator: View {
    var body: some View {
        ZStack{
            HStack {
                Image(systemName: "crown.fill")
                
                Text("Kalle")
                    .font(.custom("Skrapbook", size: 16))
                
                Text("5/6")
                    .font(.custom("Skrapbook", size: 16))
            }
            .padding()
        }
        .background{
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.85, green: 0.85, blue: 0.85))
                .frame(width: 109, height: 32)
        }
    }
}

#Preview {
    CurrentWinnerIndicator()
}
