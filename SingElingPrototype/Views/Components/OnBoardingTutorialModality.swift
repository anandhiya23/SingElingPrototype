//
//  OnBoardingTutorialModality.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 11/11/24.
//

import SwiftUI

struct OnBoardingTutorialModality: View {
    @State private var currentPage = 0
    let totalPages = 8
    @EnvironmentObject var gameManager: GameManager
    @Binding var curView: Int
    
    var body: some View {
        ZStack{
            Image("OnBoardingBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            //            VStack {
            //                Spacer()
            //
            //                RoundedRectangle(cornerRadius: 20)
            //                    .fill(Color(.systemBackground).opacity(0.9))
            //                    .frame(width: 410, height: 420)
            //                    .overlay(
            //                        VStack {
            //                            TabView(selection: $currentPage) {
            //                                onboardingPage(
            //                                    title: "BACKGROUND STORY",
            //                                    description: """
            //                                    Game ini mengangkat unsur Tata Krama yang melekat dalam Budaya Jawa.
            //
            //                                    Apakah anda dapat mengurutkan kejadian berdasarkan level ketidaksopanan?
            //                                    """,
            //                                    tag: 0
            //                                )
            //                                onboardingPage(
            //                                    title: "Aturan bermain",
            //                                    description: """
            //                                    Setiap Pemain Akan Mendapatkan 1 Kartu Untuk Memulai Permainan.
            //
            //                                    Minimal Anggota Yang Diperlukan Untuk Bermain Adalah 3 Orang Dan Maksimalnya Adalah 4 Orang.
            //                                    """,
            //                                    tag: 1
            //                                )
            //                                onboardingPage(
            //                                    title: "Giliran bermain",
            //                                    description: """
            //                                    Atur urutan bermain dengan menyeret nama pemain sesuai giliran yang diinginkan.
            //
            //                                    Setiap peran akan ada gilirannya!
            //                                    """,
            //                                    tag: 2
            //                                )
            //                                onboardingPage(
            //                                    title: "Pembaca",
            //                                    description: """
            //                                    Membacakan kartu kepada penebak tentang perkiraan indeks ketidaksopanan.
            //                                    """,
            //                                    tag: 3
            //                                )
            //                                onboardingPage(
            //                                    title: "Penebak",
            //                                    description: """
            //                                    Menebak rentang indeks ketidaksopanan kartu yang dibacakan.
            //                                    """,
            //                                    tag: 4
            //                                )
            //                                onboardingPage(
            //                                    title: "Pemantau",
            //                                    description: """
            //                                    Mengamati rentang angka yang ditebak oleh penebak untuk strategi di giliran berikutnya.
            //                                    """,
            //                                    tag: 5
            //                                )
            //                                onboardingPage(
            //                                    title: "Memenangkan kartu",
            //                                    description: """
            //                                    Jika penebak berhasil menebak rentang indeks, kartu menjadi miliknya.
            //                                    """,
            //                                    tag: 6
            //                                )
            //                                VStack(spacing: 16) {
            //                                    Text("Syarat kemenangan")
            //                                        .font(.custom("Skrapbook", size: 40))
            //                                        .foregroundColor(.black)
            //                                        .padding(.bottom, 30)
            //
            //                                    Text("""
            //                                    Permainan berakhir ketika salah satu pemain berhasil mengumpulkan total 5 kartu.
            //                                    """)
            //                                        .font(.custom("Skrapbook", size: 24))
            //                                        .multilineTextAlignment(.center)
            //                                        .foregroundColor(.singElingRB50)
            //
            //                                    ButtonComponent(width: 200, height: 64, action: {
            //                                        print("Button tapped")
            //                                    }, buttonModel: ButtonModel(button: .lanjut))
            //                                }
            //                                .tag(7)
            //                                .padding()
            //                            }
            //                            .tabViewStyle(PageTabViewStyle())
            ////                            .indexViewStyle(.hidden)
            //
            //                            HStack(spacing: 8) {
            //                                ForEach(0..<totalPages, id: \.self) { index in
            //                                    if index == currentPage {
            //                                        Capsule()
            //                                            .fill(Color.singElingRB50)
            //                                            .frame(width: 20, height: 8)
            //                                    } else {
            //                                        Circle()
            //                                            .fill(Color.singElingRB50.opacity(0.5))
            //                                            .frame(width: 8, height: 8)
            //                                    }
            //                                }
            //                            }
            //                            .padding(.bottom, 80)
            //                        }
            //                    )
            //                    .padding(.horizontal, 24)
            //                    .shadow(radius: 10)
            //
            //                Spacer()
            //                    .frame(height: 20)
            //            }
            //        }
            //    }
            //
            //    private func onboardingPage(title: String, description: String, tag: Int) -> some View {
            //        VStack(spacing: 16) {
            //            Text(title)
            //                .font(.custom("Skrapbook", size: 40))
            //                .foregroundColor(.black)
            //                .padding(.bottom, 30)
            //
            //            Text(description)
            //                .font(.custom("Skrapbook", size: 24))
            //                .multilineTextAlignment(.center)
            //                .foregroundColor(.singElingRB50)
            //        }
            //        .tag(tag)
            //        .padding()
            //    }
            //}
            VStack {
                Spacer()
                ZStack {
                    // Background color with floral pattern overlay
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.singElingDS50).opacity(0.9))
                        .frame(width: 400, height: 420)
                        .shadow(color: Color.black.opacity(0.25), radius: 10, x: 0, y: -10)
                        .overlay(
                            Image("ModalityMask") 
                                .resizable()
                                .scaledToFill()
                                .opacity(1)
                                .blendMode(.overlay)
                                .clipped()
                                .zIndex(0)
                        )
                        .overlay(
                            VStack {
                                CustomTabView(
                                    pages: [
                                        onboardingPage(
                                            title: "BACKGROUND STORY",
                                            description: """
                                        Game ini mengangkat unsur Tata Krama yang melekat dalam Budaya Jawa.
                                        Apakah anda dapat mengurutkan kejadian berdasarkan level ketidaksopanan?
                                        """
                                        ),
                                        onboardingPage(
                                            title: "Aturan bermain",
                                            description: """
                                        Setiap Pemain Akan Mendapatkan 1 Kartu Untuk Memulai Permainan.
                                        Minimal Anggota Yang Diperlukan Untuk Bermain Adalah 3 Orang Dan Maksimalnya Adalah 4 Orang.
                                        """
                                        ),
                                        onboardingPage(
                                            title: "Giliran bermain",
                                            description: """
                                        Atur urutan bermain dengan menyeret nama pemain sesuai giliran yang diinginkan.
                                        Setiap peran akan ada gilirannya!
                                        """
                                        ),
                                        onboardingPage(
                                            title: "Pembaca",
                                            description: """
                                        Membacakan kartu kepada penebak tentang perkiraan indeks ketidaksopanan.
                                        """
                                        ),
                                        onboardingPage(
                                            title: "Penebak",
                                            description: """
                                        Menebak rentang indeks ketidaksopanan kartu yang dibacakan.
                                        """
                                        ),
                                        onboardingPage(
                                            title: "Pemantau",
                                            description: """
                                        Mengamati rentang angka yang ditebak oleh penebak untuk strategi di giliran berikutnya.
                                        """
                                        ),
                                        onboardingPage(
                                            title: "Memenangkan kartu",
                                            description: """
                                        Jika penebak berhasil menebak rentang indeks, kartu menjadi miliknya.
                                        """
                                        ),
                                        onboardingPage(
                                            title: "Syarat kemenangan",
                                            description: """
                                        Permainan berakhir ketika salah satu pemain berhasil mengumpulkan total 5 kartu.
                                        """,
                                            showButton: true
                                        )
                                    ],
                                    currentPage: $currentPage
                                )
                                
                                // Custom Page Indicator
                                HStack(spacing: 8) {
                                    ForEach(0..<totalPages, id: \.self) { index in
                                        if index == currentPage {
                                            Capsule()
                                                .fill(Color.singElingRB50)
                                                .frame(width: 20, height: 8)
                                        } else {
                                            Circle()
                                                .fill(Color.singElingRB50.opacity(0.5))
                                                .frame(width: 8, height: 8)
                                        }
                                    }
                                }
                                .padding(.bottom, 80)
                            }
                        )
                        .padding(.horizontal, 24)
                        .shadow(radius: 10)
                    
                    Spacer()
                        .frame(height: 20)
                }
            }
        }
    }
}

func onboardingPage(title: String, description: String, showButton: Bool = false) -> some View {
    VStack(spacing: 16) {
        Text(title)
            .font(.custom("Skrapbook", size: 40))
            .foregroundColor(.black)
            .padding(.bottom, 30)
        
        Text(description)
            .font(.custom("Skrapbook", size: 24))
            .multilineTextAlignment(.center)
            .foregroundColor(.singElingRB50)
        
        if showButton {
            ButtonComponent(width: 200, height: 64, action: {
                print("Button tapped")
            }, buttonModel: ButtonModel(button: .lanjut))
        }
    }
    .padding()
    .background(Color.clear)
}

#Preview {
    OnBoardingTutorialModality(curView: .constant(0))
        .environmentObject(GameManager(username: "Haliza"))
}
