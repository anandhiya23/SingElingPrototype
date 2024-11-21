//
//  OnBoardingButtonComponent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 11/11/24.
//

import SwiftUI
import Combine

struct OnBoardingButtonComponent: View {
    var width: CGFloat
    var height: CGFloat
    var action: () -> Void
    var onBoardingButtonModel: OnBoardingButtonModel

    @State private var curView: Int = 6
    @StateObject private var timerManager = ButtonTimerManager()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.singElingDS70))
                .frame(width: width, height: height)
                .offset(y: height / 7)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(timerManager.shouldAnimate ? Color.black : Color.singGray, lineWidth: 3)
                        .frame(width: width, height: height)
                        .offset(y: height / 7)
                }
            
            RoundedRectangle(cornerRadius: 12)
                .fill(timerManager.shouldAnimate ? Color.singElingZ50 : Color.singGray2)
                .frame(width: width, height: height)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(timerManager.shouldAnimate ? Color.black : Color.singGray, lineWidth: 3)
                        .frame(width: width, height: height)
                }

            Text(onBoardingButtonModel.buttonText)
                .font(.custom("Skrapbook", size: 25))
                .foregroundColor(timerManager.shouldAnimate ? Color.singElingBlack : Color.singGray)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
        }
        .onTapGesture {
            action()
        }
        .frame(width: width, height: height)
        .onAppear {
            timerManager.startTimer()
        }
    }
}

class ButtonTimerManager: ObservableObject {
    @Published var shouldAnimate: Bool = false
    private var cancellable: AnyCancellable?

    func startTimer() {
        shouldAnimate = false
        cancellable?.cancel()
        
        cancellable = Timer.publish(every: 5, on: .main, in: .common)
            .autoconnect()
            .first()
            .sink { [weak self] _ in
                self?.shouldAnimate = true
            }
    }
}


#Preview {
    OnBoardingButtonComponent(width: 160, height: 64, action: {
           print("Button tapped")
       }, onBoardingButtonModel: OnBoardingButtonModel(onBoardingButton: .lanjut))

}
