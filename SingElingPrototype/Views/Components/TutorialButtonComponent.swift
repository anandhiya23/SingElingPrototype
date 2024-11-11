//
//  TutorialButtonComponent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 10/11/24.
//

import SwiftUI

struct TutorialButtonComponent: View {
    var width: CGFloat
    var height: CGFloat
    var action: () -> Void
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(red: 0.855, green: 0.651, blue: 0.505))
                .frame(width: width, height: height)
                .offset(y: height / 7)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 4) // Add stroke here
                        .frame(width: width, height: height)
                        .offset(y: height / 7)
                }
            
            
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(width: width, height: height)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 4)
                        .frame(width: width, height: height)
                }
      
                Image("si_info-fill")
                    .resizable()
                    .frame(width: 51, height: 51)
                    .scaledToFit()
                    

            .padding()
        }
        .onTapGesture {
            action()
        }
        .frame(width: width, height: height)
    }
}


#Preview {
    TutorialButtonComponent(width: 82, height: 66) {
        print("button pressed")
    }
}
