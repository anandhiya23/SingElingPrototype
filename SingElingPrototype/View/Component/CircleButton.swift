//
//  CircleButton.swift
//  SingElingPrototype
//
//  Created by Lazuardhi Imani Ahfar on 23/10/24.
//

import SwiftUI

struct CircleButton: View {
    var diameter: CGFloat
    var icon: String = "arrow.left"
    
    @State private var isPressed: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.black.opacity(0.3))
                .scaleEffect(x: 1.15, y: 1.13)
                .frame(width: diameter)
                .offset(y: diameter / 9)
            
            Circle()
                .fill(Color.singButtonLight)
                .shadow(color: Color.singButtonDark.opacity(isPressed ? 0 : 1),
                        radius: 0,
                        x: 0,
                        y: diameter / 9)
                .overlay(
                    Image(systemName: icon)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                )
                .frame(width: diameter)
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .offset(y: isPressed ? diameter / 9 : 0)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        isPressed = true
                        playClick()
                    }completion: {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            isPressed = false
                        }
                    }
                }
        }
        .frame(width: diameter, height: diameter)
    }
}


#Preview {
    CircleButton(diameter: 60, icon: "arrow.right")
}
