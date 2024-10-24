//
//  TestGameView.swift
//  SingElingPrototype
//
//  Created by Bintang Anandhiya on 19/10/24.
//

import Foundation
import SwiftUI

struct TestGameView: View {
    @State var vw: CGFloat = 0
    @State var vh: CGFloat = 0
    var vmode: Int{
        2
    }
    
    @State var temptest = [0,1,2,3,4,5,6]
    @State var myCardPos = 4
    
    var midCardY: CGFloat {
        switch vmode {
        case 0:
            return 55 / 100 * vh
        case 1:
            return 33 / 100 * vh
        default:
            return 64 / 100 * vh
        }
    }
    
    var body: some View {
        GeometryReader { geom in
            ZStack{
                HStack{
                    Button("Left"){
                        withAnimation(.bouncy.speed(1.4)) {
                            myCardPos = max(myCardPos - 1, 0)
                        }
                    }
                    .padding()
                    .foregroundStyle(.white)
                    .background{
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(.blue)
                    }
                    Button("Right"){
                        withAnimation(.bouncy.speed(1.4)) {
                            myCardPos = min(myCardPos + 1, temptest.count)
                        }
                    }
                    .padding()
                    .foregroundStyle(.white)
                    .background{
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(.blue)
                    }
                    .font(.custom("Skrapbook", size: 24))
                }
                //SELF'S CARDS
                
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(Color.black.opacity(0.7), style: StrokeStyle(lineWidth: 4, lineCap: .round, dash: [10,13]))
                    .frame(width: 170, height: 170*1.35)
                    .foregroundColor(.clear)
                    .position(x:vw/2, y: vmode == 0 || vmode == 1 ? 83.5/100*vh : 1.5*vh)
                ZStack(){
                    HStack(spacing: -85){
                        ForEach(temptest.indices, id: \.self){ curCardIdIndice in
                            RoundedRectangle(cornerRadius: 8.0)
                                .fill(Color.gray)
                                .stroke(Color.black, lineWidth: 2)
                                .frame(width: 170, height: 170*1.35)
                                .padding(.leading, curCardIdIndice == myCardPos ? 130 : 0)
                        }
                    }
                    .padding(.leading, (vw/2) - CGFloat(myCardPos * 85))
                    .frame(width: vw, alignment: .leading)
                    
                }
                
                .position(x:vw/2, y: vmode == 1 ? -145 : 26/100*vh)
                .animation(.default, value: vmode)
                
                RoundedTriangle(cornerRadius: 8)
                    .fill(Color.black)
                    .frame(width: 70, height: 60)
                    .position(x:vw/2, y: vmode == 1 ? -145 : 37.5/100*vh)
                
            }
            .frame(width: vw, height: vh)
            .onChange(of: geom.size) { oldValue, newValue in
                vw = newValue.width
                vh = newValue.height
            }
            .onAppear{
                vw = geom.size.width
                vh = geom.size.height
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    TestGameView()
}
