//
//  CountDownView.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 10/11/24.
//

import SwiftUI

struct CountdownView: View {
    @State private var countdownNumber = 4
    @State private var timer: Timer?
    @EnvironmentObject var gameManager: GameManager
    @Binding var curView: Int
    
    var body: some View {
        ZStack {
            Image("Tikar Cream")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            if countdownNumber == 3 {
                Image("Count-Three")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 400)
                    .transition(.opacity)
            } else if countdownNumber == 2 {
                Image("Count-Two")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 400)
                    .transition(.opacity)
            } else if countdownNumber == 1 {
                Image("Count-One")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 400)
                    .transition(.opacity)
            }
        }
        .onAppear {
            startCountdown()
        }
    }
    
    private func startCountdown() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                if countdownNumber > 1 {
                    countdownNumber -= 1
                } else {
                    timer?.invalidate()
                    timer = nil
                    curView = 2
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.easeInOut(duration: 0.5)) {
                countdownNumber -= 1
            }
        }
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView(curView: .constant(0))
            .environmentObject(GameManager(username: "Haliza"))
    }
}
