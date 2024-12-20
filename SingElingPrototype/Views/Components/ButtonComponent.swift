//
//  SetujuButton.swift
//  SingElingPrototype
//
//  Created by Lazuardhi Imani Ahfar on 24/10/24.
//

import SwiftUI

struct ButtonComponent: View {
    var buttonModel: ButtonModel
    var width: CGFloat
    var height: CGFloat
    @Binding var isButtonEnabled: Bool
    
    var action: () -> Void
    
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(red: 0.855, green: 0.651, blue: 0.505))
                .frame(width: width, height: height)
                .offset(y: height / 7)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isButtonEnabled ? Color.singElingBlack : .singGray, lineWidth: 4)
                        .frame(width: width, height: height)
                        .offset(y: height / 7)
                }
            
            
            RoundedRectangle(cornerRadius: 12)
                .fill(isButtonEnabled
                      ? (buttonModel.button == .taruh
                          ? .singElingZ30
                          : (buttonModel.button == .yakin
                              ? .singElingZ50
                              : (buttonModel.button == .tidak || buttonModel.button == .hapus
                                  ? .singPink
                                  : .white)))
                      : .singGray2)

                .frame(width: width, height: height)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isButtonEnabled ? Color.singElingBlack : .singGray, lineWidth: 4)
                        .frame(width: width, height: height)
                }
            HStack{
                Image(buttonModel.imageName)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 51, height: 51)
                    .scaledToFit()
                    .foregroundColor(isButtonEnabled ? Color.singElingBlack : .singGray)
                    
                
                Text(buttonModel.buttonText)
                    .font(.custom("Skrapbook", size: 25))
                    .foregroundColor(isButtonEnabled ? Color.singElingBlack : .singGray)
            }
            .frame(width: width, height: height)
            .padding()
        }
        .disabled(!isButtonEnabled)
        .onTapGesture {
            if isButtonEnabled { 
                            action()
                            print("action di tap")
                        }
        }
    }
}

#Preview {
    ButtonComponent(
        buttonModel: ButtonModel(button: .hapus),
        width: 190,
        height: 64,
        isButtonEnabled: .constant(false))
    {
        print("button tapped")
    }
}

