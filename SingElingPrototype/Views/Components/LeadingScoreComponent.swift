//
//  LeadingScoreComponent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 10/11/24.
//

import SwiftUI

struct LeadingScoreComponent: View {
    var body: some View {
        HStack{
            Image("solar_crown-bold")
            
            Text("Ray")
                .font(.custom("skrapbook", size: 16))
            
            Text("4/5")
                .font(.custom("skrapbook", size: 16))
        }
        .frame(width: 91, height: 32)
        .cornerRadius(20)
        .background(Color.singElingYellow)
    }
}

#Preview {
    LeadingScoreComponent()
}
