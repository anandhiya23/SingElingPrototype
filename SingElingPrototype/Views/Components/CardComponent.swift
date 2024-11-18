//
//  CardComponent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 23/10/24.
//

import SwiftUI

struct CardComponent: View {
    var width: CGFloat
    var height: CGFloat {
        self.width * 1.65
    }
    
    var text: String
    var indexNum: Int
    var backgroundImage: String
    
    let referenceWidth: CGFloat = 300
    let yOffsetReference: CGFloat = -50
    
    var adjustedYOffset: CGFloat {
        yOffsetReference * (width / referenceWidth)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: width / 15)
                .fill(Color.clear)
                .background(
                    Image(backgroundImage)
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: width / 15))
                )
                .frame(width: width, height: height)
                .shadow(radius: width * 0.05)

            VStack {
                Text(text)
                    .font(.custom("Skrapbook", size: width * 0.10))
                    .foregroundColor(Color.singCardText)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding(.top, width * 0.15)

                Spacer()

                Text("\(indexNum)")
                    .font(.custom("Skrapbook", size: width * 0.25))
                    .foregroundColor(Color.white)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CardComponent(
                    width: 200,
                    text: "ngirim meme tanpa konteks sing jelas nang grub keluarga",
                    indexNum: 100,
                    backgroundImage: "Card36"  // Tambahkan gambar latar yang valid
                )
                .previewLayout(.sizeThatFits)
    }
}
