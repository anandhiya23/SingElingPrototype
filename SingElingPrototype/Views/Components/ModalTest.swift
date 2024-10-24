//
//  ModalTest.swift
//  SingElingPrototype
//
//  Created by Bintang Anandhiya on 24/10/24.
//

import SwiftUI

struct ModalTest: View {
    @State var isPresented = false
    var body: some View {
        VStack{
            Button("Show Sheet Modal"){
                isPresented = true
            }
            .foregroundStyle(.white)
            .padding()
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.blue)
            }
        }
        .sheet(isPresented: $isPresented){
            VStack{
            }
            .presentationDragIndicator(.visible)
            .presentationDetents([.large,.medium,.fraction(0.2)])
            .presentationBackground(.singGreen)
            .presentationBackgroundInteraction(.enabled)
                
        }
            
        
            
    }
}

#Preview {
    ModalTest()
}
