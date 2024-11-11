//
//  OnBoardingTutorialView.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 11/11/24.
//

import SwiftUI

struct OnBoardingTutorialView: View {
    var titleText: String
    var descriptionText: String
    var buttonModel: OnBoardingButtonModel
    var buttonAction: () -> Void
    
    @EnvironmentObject var gameManager: GameManager
    @Binding var curView: Int
    
    var body: some View {
        ZStack{
            Image("OnBoardingBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack{
                Image("LogoOnBoarding")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 180, height: 200)
                    .padding(.top, 200)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.singElingRB50)
                        .frame(width: 365, height: 56)
                    Text(titleText)
                        .font(.custom("skrapbook", size: 32))
                        .foregroundColor(Color.singElingDS50)
                }
                .offset(y: -55)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.singElingDS50)
                        .frame(width: 303, height: 106)
                    Text(descriptionText)
                        .font(.custom("Jua-regular", size: 20))
                        .foregroundColor(Color.singElingRB50)
                        .multilineTextAlignment(.center)
                }
                .offset(y: -40)
                
                Spacer()
                
                OnBoardingButtonComponent(width: 160, height: 64, action: buttonAction, onBoardingButtonModel: buttonModel)
                    .padding(.bottom, 60)
            }
        }
    }
}

struct OnboardingContainerView: View {
    @State private var currentPage = 0 
    
    var body: some View {
        VStack {
            if currentPage == 0 {
                OnBoardingTutorialView(
                    titleText: "Gimana pemanasannya?",
                    descriptionText: "Di Sing Eling, anda akan \nmenebak tingkat ketidaksopanan \ndalam Budaya Tata Krama Jawa.",
                    buttonModel: OnBoardingButtonModel(onBoardingButton: .siapLanjut),
                    buttonAction: {
                        currentPage = 1
                    },
                    curView: $currentPage
                )
            } else if currentPage == 1 {
                OnBoardingTutorialView(
                    titleText: "Gular gilir bergilir",
                    descriptionText: "Setiap peran akan ada gilirannya! \nDi sini anda bisa jadi \nPembaca, Penebak, atau \nPemantau.",
                    buttonModel: OnBoardingButtonModel(onBoardingButton: .lanjut),
                    buttonAction: {
                        currentPage = 2
                    },
                    curView: $currentPage
                )
            } else if currentPage == 2 {
                OnBoardingTutorialView(
                    titleText: "Ayo kumpul dulu",
                    descriptionText: "Main bareng minimal 3 orang \ndan maksimal 4 orang. \nSiap ajak teman buat \nseru-seruan?",
                    buttonModel: OnBoardingButtonModel(onBoardingButton: .udahSiap),
                    buttonAction: {
                        currentPage = 3
                    },
                    curView: $currentPage
                )
            } else if currentPage == 3 {
                OnBoardingTutorialView(
                    titleText: "Kumpulin 5 kartu",
                    descriptionText: "Kumpulin 5 kartu secepatnya \nuntuk menjadi Raja Jawa. \nJadi yang paling paham \ntata krama Jawa?",
                    buttonModel: OnBoardingButtonModel(onBoardingButton: .buktikan),
                    buttonAction: {
                        print("Lanjut ke permainan!")
                    },
                    curView: $currentPage
                )
            }
        }
        .animation(.easeInOut, value: currentPage)
        .transition(.slide)
    }
}

#Preview {
    OnboardingContainerView()
        .environmentObject(GameManager(username: "Haliza"))
}

