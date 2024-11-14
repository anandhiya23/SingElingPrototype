//
//  OnBoardingTutorialView.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 11/11/24.
//

import SwiftUI

struct OnBoardingTutorialView: View {
    var titleText: String
    var descriptionText: String?
    var buttonModel: OnBoardingButtonModel
    var buttonAction: () -> Void
    var logoImageName: String
    
    @EnvironmentObject var gameManager: GameManager
    @Binding var curView: Int
    
    var body: some View {
        ZStack{
            Image("OnBoardingBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Image(logoImageName)
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
                
                let rectangleSize = descriptionText == nil
                                    ? CGSize(width: 319, height: 216)
                                    : CGSize(width: 303, height: 106)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.singElingDS30)
                        .frame(width: rectangleSize.width, height: rectangleSize.height)
                    
                    Group {
                        if let descriptionText = descriptionText {
                            Text(descriptionText)
                                .font(.custom("Jua-regular", size: 20))
                                .foregroundColor(Color.singElingRB50)
                                .multilineTextAlignment(.center)
                        } else {
                            VStack(spacing: 10) {
                                Text("Setiap peran akan ada gilirannya!")
                                    .font(.custom("Jua-regular", size: 20))
                                    .foregroundColor(Color.singElingRB50)
                                
                                Text(" ")
                                
                                Text("Di sini anda bisa jadi")
                                    .font(.custom("Jua-regular", size: 20))
                                    .foregroundColor(Color.singElingRB50)
                                
                                HStack {
                                    Text("Pembaca")
                                        .font(.custom("Jua-regular", size: 24)) // Larger font
                                        .foregroundColor(Color.singElingRB50)
                                    
                                    Text(",")
                                        .font(.custom("Jua-regular", size: 20))
                                        .foregroundColor(Color.singElingRB50)
                                    
                                    Text("Penebak")
                                        .font(.custom("Jua-regular", size: 24)) // Larger font
                                        .foregroundColor(Color.singElingRB50)
                                    
                                    Text(", atau")
                                        .font(.custom("Jua-regular", size: 20))
                                        .foregroundColor(Color.singElingRB50)
                                }
                                
                                Text("Pemantau.")
                                    .font(.custom("Jua-regular", size: 24)) // Larger font
                                    .foregroundColor(Color.singElingRB50)
                            }
                        }
                    }
                    .offset(y: -5)
                }
                
                Spacer()
                
                OnBoardingButtonComponent(width: 160, height: 64, action: buttonAction, onBoardingButtonModel: buttonModel)
                    .padding(.bottom, 60)
            }
        }
    }
}

struct OnboardingContainerView: View {
    @State private var currentPage = 0
    @State private var curView: Int = 6
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        VStack {
            if curView == 7 {
                // Jika curView sudah 7, tampilkan MainView
                MainView()
                    .environmentObject(gameManager)
            } else {
                // Menampilkan tutorial berdasarkan currentPage
                if currentPage == 0 {
                    OnBoardingTutorialView(
                        titleText: "Gimana pemanasannya?",
                        descriptionText: "Di Sing Eling, anda akan \nmenebak tingkat ketidaksopanan \ndalam Budaya Tata Krama Jawa.",
                        buttonModel: OnBoardingButtonModel(onBoardingButton: .siapLanjut),
                        buttonAction: {
                            currentPage = 1
                        },
                        logoImageName: "LogoOnBoarding-p1",
                        curView: $curView
                    )
                } else if currentPage == 1 {
                    OnBoardingTutorialView(
                        titleText: "Indeks ketidaksopanan",
                        descriptionText: "Indeks ini digunakan untuk \nmenilai seberapa 'sopan' atau \n'nglamak' (kasar) suatu ungkapan.",
                        buttonModel: OnBoardingButtonModel(onBoardingButton: .lanjut),
                        buttonAction: {
                            currentPage = 2
                        },
                        logoImageName: "LogoOnBoarding-p1",
                        curView: $curView
                    )
                }else if currentPage == 2 {
                    OnBoardingTutorialView(
                        titleText: "Gular gilir bergilir",
                        descriptionText: nil,
                        buttonModel: OnBoardingButtonModel(onBoardingButton: .udahSiap),
                        buttonAction: {
                            currentPage = 3
                        },
                        logoImageName: "LogoOnBoarding",
                        curView: $curView
                    )
                }else if currentPage == 3 {
                    OnBoardingTutorialView(
                        titleText: "Ayo kumpul dulu",
                        descriptionText: "Main bareng minimal 3 orang \ndan maksimal 4 orang. \nSiap ajak teman buat \nseru-seruan?",
                        buttonModel: OnBoardingButtonModel(onBoardingButton: .udahSiap),
                        buttonAction: {
                            currentPage = 4
                        },
                        logoImageName: "LogoOnBoarding-p4",
                        curView: $curView
                    )
                }else if currentPage == 4 {
                    OnBoardingTutorialView(
                        titleText: "Kumpulin 5 kartu",
                        descriptionText: "Kumpulin 5 kartu secepatnya \nuntuk menjadi Raja Jawa. \nJadi yang paling paham \ntata krama Jawa?",
                        buttonModel: OnBoardingButtonModel(onBoardingButton: .buktikan),
                        buttonAction: {
                            curView = 7  // Mengubah curView jadi 7
                        },
                        logoImageName: "LogoOnBoarding",
                        curView: $curView
                    )
                }
                
            }
        }
        .animation(.easeInOut, value: currentPage)
        .transition(.slide)
    }
}

#Preview {
    OnboardingContainerView()
        .environmentObject(GameManager())
}

