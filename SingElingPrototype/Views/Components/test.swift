//
//  test.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 07/11/24.
//

import SwiftUI

struct test: View {
    @State private var isAnimated: Bool = false
    private let vw = UIScreen.main.bounds.width
    private let vh = UIScreen.main.bounds.height
    private let targetPositionY: CGFloat = UIScreen.main.bounds.height / 2 // Target position at center

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.blue)
                .frame(width: 298, height: 60)
            
            Text("Hai! Yuk Kita Main Tebak-Tebakan!")
                .font(.custom("Skrapbook", size: 20))
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
        }
        .position(x: 0.5 * vw, y: isAnimated ? targetPositionY : vh + 100) // Start from below screen
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.easeOut(duration: 1.0)) {
                    isAnimated = true // Start animation moving up after delay
                }
            }
        }
    }
}

#Preview {
    test()
}
