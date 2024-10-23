//
//  GrowingButton.swift
//  SingElingPrototype
//
//  Created by Lazuardhi Imani Ahfar on 23/10/24.
//

import SwiftUI

struct GrowingButton: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 15)
            .padding(.horizontal, 20)
            .background(isEnabled ? .black : .gray)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.1 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

