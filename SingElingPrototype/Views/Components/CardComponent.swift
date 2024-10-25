//
//  CardComponent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 23/10/24.
//

import SwiftUI

struct CardComponent: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = width * 1.65
            
            let scaleFactor = width / 300
            let adjustedYOffset: CGFloat = -50 * scaleFactor
            
            
            ZStack {
                RoundedRectangle(cornerRadius: width / 15)
                    .fill(Color.clear)
                    .background(
                        Image("BackgroundCard")
                            .resizable()
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: width / 15))
                    )
                    .frame(width: width, height: height)
                    .shadow(radius: width * 0.05)

                VStack {
                    Text("NGANGKAT SIKIL")
                        .font(.custom("Skrapbook", size: width * 0.12))
                        .foregroundColor(Color.singCardText)
                        .multilineTextAlignment(.center)
                        .padding(.top, width * 0.080)
                        .padding(.bottom, width * 0.02)

                    Text("ING NGAREPE")
                        .font(.custom("Skrapbook", size: width * 0.12))
                        .foregroundColor(Color.singCardText)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, width * 0.02)

                    Text("ORANG TUWO")
                        .font(.custom("Skrapbook", size: width * 0.12))
                        .foregroundColor(Color.singCardText)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, width * 0.02)

                    Spacer()

                    HStack(spacing: -width * 0.13) {
                        Image("BirdShape")
                            .resizable()
                            .scaledToFill()
                            .frame(width: width * 0.4, height: height * 0.4)
                        Image("FootShape")
                            .resizable()
                            .scaledToFill()
                            .frame(width: width * 0.4, height: height * 0.4)
                            .offset(x: 10, y: adjustedYOffset)
                    }
                    .padding(.bottom, -width * 0.075)

                    Text("100")
                        .font(.custom("Skrapbook", size: width * 0.25))
                        .foregroundColor(Color.white)
                        .padding(.bottom, width * 0.01)
                        .padding(.horizontal, width * 0.1)
                        .background(
                            RoundedRectangle(cornerRadius: width * 0.1)
                                .fill(Color.singDarkGreen)
                        )
                }
                .padding(width * 0.05)
            }
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: width / 15))
            .overlay(
                RoundedRectangle(cornerRadius: width / 15)
                    .stroke(Color.black, lineWidth: width * 0.03)
            )
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardComponent()
            .frame(width: 300)
            .previewLayout(.sizeThatFits)
    }
}
