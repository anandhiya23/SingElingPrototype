//
//  CurrentWinnerIndicator.swift
//  SingElingPrototype
//
//  Created by Lazuardhi Imani Ahfar on 24/10/24.
//

import SwiftUI

struct CurrentWinnerIndicator: View {
    var width: CGFloat
    var height: CGFloat
    var icon: String = "crown.fill"
    var leader: String = ""
    var point: Int = 0
    
    var body: some View {
        ZStack{
            HStack {
                Image(systemName: icon)
                
                
                Text(leader)
                    .font(.custom("Skrapbook", size: 16))
                
                Text("\(point + 1)/6")
                    .font(.custom("Skrapbook", size: 16))
            }
            .padding()
        }
        .background{
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.85, green: 0.85, blue: 0.85))
                .frame(width: width, height: height)
        }
    }
}

#Preview {
    CurrentWinnerIndicator(width: 109, height: 32, icon: "crown.fill", leader: "Kalle", point: 4)
}
