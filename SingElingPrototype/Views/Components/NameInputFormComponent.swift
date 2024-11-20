//
//  NameInputFormComponent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 28/10/24.
//

import SwiftUI

struct NameInputFormComponent: View {
    @EnvironmentObject var gameManager: GameManager
    @State private var name: String = ""
    @State private var hasSavedName = false
    
    var isNameValid: Bool {
        name.count  <= 8
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 0) {
                TextField("KETIK NAMAMU DISINI", text: $name)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color.backgroundCream)
                    .frame(height: 50)
                    .font(.custom("skrapbook", size: 24))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.7), lineWidth: 1)
                    )
                    .foregroundColor(name.count <= 8 ? .black : .singTextGray)
                Button(action: {
                    if !hasSavedName {
                        print("Button ditekan")
                        if !name.isEmpty {
                            
                            if isNameValid{
                                gameManager.myUsername = name
                                print("Nama \(name) berhasil disimpan ke UserDefaults")
                                hasSavedName = true
                                
                                gameManager.curView = 1
//                                showValidationError = true
                            }
                            
                        } else {
                            print("Nama kosong, tidak bisa lanjut.")
//                            showValidationError = false
                        }
                    }
                }) {
                    Text("LANJUT")
                        .font(.custom("skrapbook", size: 24))
                        .foregroundColor(name.isEmpty && !isNameValid ? .singGray : .black)
                        .frame(width: 100, height: 50)
                        .background(name.isEmpty && !isNameValid ? .singGray3 : .singGreen)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.black, lineWidth: 3)
                        )
                    
                }
                .disabled(name.isEmpty || !isNameValid)
                
                //                test buat hapus username
                
                //                                Button(action: {
                //                                                gameManager.clearSavedName()  // Hapus username dari UserDefaults
                //                                                name = "" // Kosongkan field TextField
                //                                            }) {
                //                                                Text("HAPUS")
                //                                                    .font(.custom("skrapbook", size: 24))
                //                                                    .foregroundColor(.white)
                //                                                    .frame(width: 100, height: 50)
                //                                                    .background(Color.red)
                //                                                    .overlay(
                //                                                        RoundedRectangle(cornerRadius: 0)
                //                                                            .stroke(Color.black, lineWidth: 3)
                //                                                    )
                //                                            }
                
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 6)
            )
            .cornerRadius(10)
            .padding(.horizontal)
            
            if !isNameValid {
                ZStack {
                    BubbleShape()
                        .fill(Color.singOrange)
                        .frame(width: 143, height: 45)
                        .overlay(
                            Text("MAKSIMAL 8 HURUF")
                                .font(.custom("skrapbook", size: 18))
                                .foregroundColor(.black)
                                .padding(.top, 10)
                        )
                }
                .offset(y: -25)
            }
        }
    }
}

struct BubbleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let radius: CGFloat = 10
        let triangleOffset: CGFloat = -40
        let triangleHeight: CGFloat = 10
        let triangleBaseHalfWidth: CGFloat = 15
        let triangleCurveRadius: CGFloat = 6
        
        path.addRoundedRect(in: CGRect(x: 0, y: radius, width: rect.width, height: rect.height - radius), cornerSize: CGSize(width: radius, height: radius))
        
        path.move(to: CGPoint(x: rect.midX + triangleOffset - triangleBaseHalfWidth, y: radius))
        
        path.addLine(to: CGPoint(x: rect.midX + triangleOffset - triangleCurveRadius, y: radius - triangleHeight))
        
        path.addQuadCurve(
            to: CGPoint(x: rect.midX + triangleOffset + triangleCurveRadius, y: radius - triangleHeight),
            control: CGPoint(x: rect.midX + triangleOffset, y: radius - triangleHeight - triangleCurveRadius)
        )
        
        path.addLine(to: CGPoint(x: rect.midX + triangleOffset + triangleBaseHalfWidth, y: radius))
        
        path.closeSubpath()
        
        return path
    }
}


#Preview {
    @State var curView: Int = 0

        return NameInputFormComponent()
            .environmentObject(GameManager())
}
