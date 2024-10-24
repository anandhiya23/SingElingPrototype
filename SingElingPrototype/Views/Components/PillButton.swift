//
//  PillButton.swift
//  SingElingPrototype
//
//  Created by Lazuardhi Imani Ahfar on 23/10/24.
//

import SwiftUI

struct PillButton: View {
    var width: CGFloat
    var height: CGFloat
    var icon: String = "arrow.left"
    
    @State private var isPressed: Bool = false
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(.black.opacity(0.3))
                .scaleEffect(x: 1.1, y: 1.13)
                .frame(width: width, height: height)
                .offset(y: height / 9)
            
            Capsule()
                .fill(Color.singButtonLight)
                .shadow(color: Color.singButtonDark.opacity(isPressed ? 0 : 1),
                        radius: 0,
                        x: 0,
                        y: height / 9)
                .overlay(
                    Image(systemName: icon)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                )
                .frame(width: width, height: height)
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .offset(y: isPressed ? height / 9 : 0)
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
        .frame(width: width, height: height + (height / 9))
    }
}


#Preview {
    PillButton(width: 150, height: 60, icon: "checkmark")
}
