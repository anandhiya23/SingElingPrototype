//
//  LeaveConfirmationView.swift
//  SingElingPrototype
//
//  Created by Lazuardhi Imani Ahfar on 19/11/24.
//

import SwiftUI

struct LeaveConfirmationView: View {
    @StateObject  var gamePlayViewModel = GamePlayViewModel()
    
    var vw: CGFloat = 402
    var vh: CGFloat = 874
    
    let onConfirm: () -> Void
    let onCancel: () -> Void
    
    var body: some View {
        ZStack{
            ZStack {
                Rectangle()
                    .fill(Color.gray)
                    .opacity(0.75)
            }
            .frame(width: vw, height: vh)
            
            VStack{
                Spacer()
                StatementComponent(width: 300, statementRole: StatementRole(userRole: .leaveConfirmation))
                    
                
                HStack {
//                    ButtonComponent(buttonModel: ButtonModel(button: .tidak), width: 150, height: 73){
//                        onCancel()
//                    }
                    
                    ButtonComponent(buttonModel: ButtonModel(button: .tidak), width: 150, height: 73, isButtonEnabled: $gamePlayViewModel.isButtonEnabled){
                        onCancel()
                    }
//                    ButtonComponent(buttonModel: ButtonModel(button: .yakin), width: 150, height: 73){
//                        onConfirm()
//                    }
                    ButtonComponent(buttonModel: ButtonModel(button: .yakin), width: 150, height: 73, isButtonEnabled: $gamePlayViewModel.isButtonEnabled){
                        onConfirm()
                    }
                }
                
                Spacer()
            }
            .position(x:vw/2, y:  0.4*vh)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LeaveConfirmationView(
        onConfirm: {
            print("Confirm")
        },
        onCancel: {
            print("Cancel")
        }
    )
}
