//
//  OnBoardingButtonComponent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 11/11/24.
//

//import SwiftUI
//import Combine
//
//struct OnBoardingButtonComponent: View {
//    var width: CGFloat
//    var height: CGFloat
//    var action: () -> Void
//    
//    
//    var onBoardingButtonModel: OnBoardingButtonModel
//
//    @State private var isInitialColor = true
//    @StateObject private var timerManager = ButtonTimerManager()
//    
//    var body: some View {
//        ZStack{
//            RoundedRectangle(cornerRadius: 12)
//                .fill(Color(.singElingDS70))
//                .frame(width: width, height: height)
//                .offset(y: height / 7)
//                .overlay {
//                    RoundedRectangle(cornerRadius: 12)
////                        .stroke(isInitialColor ? Color.singGray : Color.black, lineWidth: 3)
//                        .stroke(timerManager.shouldAnimate ? Color.black : Color.singGray, lineWidth: 3)
//                        .frame(width: width, height: height)
//                        .offset(y: height / 7)
//                }
//            
//            RoundedRectangle(cornerRadius: 12)
////                .fill(isInitialColor ? Color.singGray2 : Color.singElingZ50)
//                .fill(timerManager.shouldAnimate ? Color.singElingZ50 : Color.singGray2)
//                .frame(width: width, height: height)
//                .overlay {
//                    RoundedRectangle(cornerRadius: 12)
////                        .stroke(isInitialColor ? Color.singGray : Color.black, lineWidth: 3)
//                        .stroke(timerManager.shouldAnimate ? Color.black : Color.singGray, lineWidth: 3)
//                        .frame(width: width, height: height)
//                }
//
//            Text(onBoardingButtonModel.buttonText)
//                .font(.custom("Skrapbook", size: 25))
////                .foregroundColor(isInitialColor ? Color.singGray : Color.singElingBlack)
//                .foregroundColor(timerManager.shouldAnimate ? Color.singElingBlack : Color.singGray)
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .multilineTextAlignment(.center)
//                .padding(.horizontal, 16)
//        }
//        .onTapGesture {
//            action()
//        }
//        .frame(width: width, height: height)
//        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                withAnimation(.easeInOut(duration: 1)) {
//                    isInitialColor = false
//                }
//            }
//        }
//    }
//}
//
//class ButtonTimerManager: ObservableObject {
//    @Published var shouldAnimate: Bool = false
//    private var cancellable: AnyCancellable?
//
//    init() {
//        startTimer()
//    }
//    
//    private func startTimer() {
//        cancellable = Timer.publish(every: 5, on: .main, in: .common)
//            .autoconnect()
//            .first() // Trigger only once after 5 seconds
//            .sink { [weak self] _ in
//                self?.shouldAnimate = true
//            }
//    }
//    
//    func resetTimer() {
//        shouldAnimate = false
//        cancellable?.cancel()
//        startTimer()
//    }
//}
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
            timerManager.startTimer()  // Start timer on each appearance
        }
    }
}

class ButtonTimerManager: ObservableObject {
    @Published var shouldAnimate: Bool = false
    private var cancellable: AnyCancellable?

    func startTimer() {
        shouldAnimate = false // Reset animation state
        cancellable?.cancel() // Cancel any existing timer
        
        cancellable = Timer.publish(every: 5, on: .main, in: .common)
            .autoconnect()
            .first() // Trigger only once after 5 seconds
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
