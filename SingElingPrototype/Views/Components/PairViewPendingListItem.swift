//
//  PairViewPendingListItem.swift
//  SingElingPrototype
//
//  Created by Lazuardhi Imani Ahfar on 23/10/24.
//

import SwiftUI


struct PairViewPendingListItem: View {
    @State var hasBeenTapped = false
    var peerName: String
    var body: some View {
        HStack{
            Spacer()
            HStack{
                Text("\(peerName)")
                    .font(.title2)
                    .foregroundColor(Color.singElingBlack)
                    .bold()
                    .multilineTextAlignment(.center)
                if hasBeenTapped{
                    ProgressView()
                        .padding(.leading, 2)
                }
            }
            Spacer()
        }
        .padding()
        .frame(width: 300, height: 80)
        .background{
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
                .strokeBorder(.black, lineWidth: 3)
        }
        .onTapGesture {
            hasBeenTapped = true
        }
    }
}
#Preview {
    PairViewPendingListItem(peerName: "Lorem")
}
