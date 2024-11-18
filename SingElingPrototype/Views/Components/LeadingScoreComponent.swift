//
//  LeadingScoreComponent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 10/11/24.
//

import SwiftUI

struct LeadingScoreComponent: View {
    var players = [
        Player(name: "Rayhan", point: 0, color: CodableColor(color: .red)),
        Player(name: "Alice", point: 0, color: CodableColor(color: .blue)),
        Player(name: "John", point: 0, color: CodableColor(color: .green))
    ]

    var leader: Player? {
        players.max(by: { $0.point < $1.point })
    }
    var maxScore: String = "5"
    
    var body: some View {
        HStack{
            Image("solar_crown-bold")
            
            Text(leader!.name.prefix(3))
                .font(.custom("skrapbook", size: 16))
                            
            Text("\(leader!.point+1)/5")
                .font(.custom("skrapbook", size: 16))
        }
        .frame(width: 91, height: 32)
        .cornerRadius(20)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.singElingYellow)
        )
    }
}

#Preview {
    LeadingScoreComponent()
}
