//
//  CardThrowView.swift
//  SingElingPrototype
//
//  Created by Lazuardhi Imani Ahfar on 18/11/24.
//

import SwiftUI

struct CardThrowView: View {
    @State var tampilKartu: Bool = false
    @State var buangKartu: Bool = false
    @State var putarKartu: Bool = false

    var cardText: String = "test card"
    var cardNum: Int = 1
    var backgroundImage: String = "Card1"
    var vw: CGFloat = 402
    var vh: CGFloat = 874
    
    var vmode: Int{
        2
    }
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
    
    
    @State private var roleTimer1: Int = 0
    @State private var timer1: Timer?
    func startTimer1() {
        resetTimer1()
        timer1 = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            roleTimer1 += 1
            print("\(roleTimer1)")
            if roleTimer1 == 1{
                self.tampilKartu = true
            }
            if roleTimer1 == 2{
                self.putarKartu = true

            }
            if roleTimer1 == 3{
                self.buangKartu = true
            }
            if roleTimer1 == 4{
                stopTimer1()

            }
        }
    }

    func stopTimer1() {
        timer1?.invalidate()
        timer1 = nil
    }

    func resetTimer1() {
        stopTimer1()
        roleTimer1 = 0
    }
    
    var body: some View {
        ZStack{
            ZStack {
                Rectangle()
                    .fill(Color.gray)
                    .opacity(0.75)
            }
            .frame(width: vw, height: vh)
            
            StatementComponent(width: 300, statementRole: StatementRole(userRole: .cardThrowView))
                .position(x:vw/2, y: buangKartu ? 0.4*vh : -145)
                .animation(.bouncy.speed(1.5), value: buangKartu)

            
            Image("GarbageBehind")
                .resizable()
                .scaledToFit()
                .position(x: 1/2 * vw, y: 0.9 * vh)
            
            CardComponent(width: 216, text: cardText, indexNum: cardNum, backgroundImage: backgroundImage)
                .rotationEffect(.degrees(putarKartu ? 16 : 0))
                .position(x: 1/2*vw, y: buangKartu ? vh : (tampilKartu ? 50 / 100 * vh : -40 / 100 * vh))
                .animation(.bouncy.speed(0.8), value: tampilKartu)
                .animation(.bouncy.speed(0.8), value: putarKartu)
                .animation(.bouncy.speed(1.4), value: buangKartu)
            
            Image("GarbageFront 1")
                .resizable()
                .scaledToFit()
                .position(x: 1/2 * vw, y: 0.95 * vh)
        }
        .onAppear{
            startTimer1()
        }
    }
}

#Preview {
    CardThrowView()
}
