//
//  NameInputFormComponent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 28/10/24.
//

import SwiftUI

struct NameInputFormComponent: View {
    @State private var name: String = Defaults.getName()
    
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
                    .foregroundColor(name.count < 3 ? .black : .singTextGray)
                    .onChange(of: name) { newName in
                        if newName.isEmpty {
                            Defaults.clearName() // hapus dari UserDefaults kalo kosong
                        } else {
                            Defaults.save(name: newName) // simpan ke UserDefaults jika ada teks
                        }
                    }
                
                Button(action: {
                    Defaults.save(name: name)
                    print("Nama yang disimpan: \(name)")
                }) {
                    Text("LANJUT")
                        .font(.custom("skrapbook", size: 24))
                        .foregroundColor(name.isEmpty ? .singGray : .black)
                        .frame(width: 100, height: 50)
                        .background(name.isEmpty ? .singGray3 : .singGreen)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.black, lineWidth: 3)
                        )
                }
                                .disabled(name.isEmpty)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 6)
            )
            .cornerRadius(10)
            .padding(.horizontal)
            
            if name.isEmpty || !Defaults.isNameSaved{
                ZStack {
                    BubbleShape()
                        .fill(Color.singOrange)
                        .frame(width: 143, height: 45)
                        .overlay(
                            Text("MAKSIMAL 3 HURUF")
                                .font(.custom("skrapbook", size: 18))
                                .foregroundColor(.black)
                                .padding(.top, 10)
                        )
                }
                .offset(y: -25)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
    NameInputFormComponent()
}
