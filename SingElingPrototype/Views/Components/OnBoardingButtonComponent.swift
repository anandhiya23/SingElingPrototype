//
//  OnBoardingButtonComponent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 11/11/24.
//

import SwiftUI

struct OnBoardingButtonComponent: View {
    var width: CGFloat
    var height: CGFloat
    var action: () -> Void
    
    var onBoardingButtonModel: OnBoardingButtonModel

    @State private var isInitialColor = true

    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.singElingDS70))
                .frame(width: width, height: height)
                .offset(y: height / 7)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isInitialColor ? Color.singGray : Color.black, lineWidth: 3)
                        .frame(width: width, height: height)
                        .offset(y: height / 7)
                }
            
            RoundedRectangle(cornerRadius: 12)
                .fill(isInitialColor ? Color.singGray2 : Color.singElingZ50)
                .frame(width: width, height: height)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isInitialColor ? Color.singGray : Color.black, lineWidth: 3)
                        .frame(width: width, height: height)
                }

            Text(onBoardingButtonModel.buttonText)
                .font(.custom("Skrapbook", size: 25))
                .foregroundColor(isInitialColor ? Color.singGray : Color.singElingBlack)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
        }
        .onTapGesture {
            action()
        }
        .frame(width: width, height: height)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation(.easeInOut(duration: 1)) {
                    isInitialColor = false
                }
            }
        }
    }
}

#Preview {
    OnBoardingButtonComponent(width: 160, height: 64, action: {
        print("Button tapped")
    }, onBoardingButtonModel: OnBoardingButtonModel(onBoardingButton: .lanjut))
}
