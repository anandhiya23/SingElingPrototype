//
//  PairViewContent.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 06/11/24.
//

import SwiftUI

struct PairViewContent: View {
    @EnvironmentObject var gameManager: GameManager
    @Binding var curView: Int

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.singElingZ50)
                .ignoresSafeArea()
            VStack {
                // Menampilkan pemain yang sudah bergabung
                if gameManager.gameState.players.isEmpty {
                    Text("Menunggu pemain lain...")
                        .font(.custom("Skrapbook", size: 20))
                        .padding()
                        .foregroundColor(.black)
                } else {
                    UserJoinComponent(width: 300)
                        .padding(.bottom, 20)
                }

                // Menampilkan peers yang tersedia (hanya untuk host)
                if gameManager.isHost && !gameManager.availablePeers.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Available Peers")
                            .font(.headline)
                            .foregroundColor(.black)
                        
                        ForEach(gameManager.availablePeers, id: \.self) { peer in
                            PairViewPendingListItem(peerName: peer.displayName)
                                .simultaneousGesture(TapGesture().onEnded {
                                    gameManager.serviceBrowser.invitePeer(peer, to: gameManager.session, withContext: nil, timeout: 30)
                                })
                        }
                    }
                    .padding()
                }

                // Tombol untuk memulai permainan (hanya untuk host)
                if gameManager.isHost {
                    RoomComponent(roomModel: RoomModel(typeRoom: .joinRoom), width: 200)
                        .padding()
                        .onTapGesture {
                            gameManager.isPlaying = true  // Host starts the game
                        }
                } else {
                    // Jika guest, tampilkan pesan bahwa hanya host yang bisa memulai permainan
                    Text("Menunggu host untuk memulai permainan...")
                        .font(.custom("Skrapbook", size: 20))
                        .padding()
                        .foregroundColor(.black)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // Pantau perubahan nilai isPlaying, jika true transisi ke gameView
        .onChange(of: gameManager.gameState.isPlaying) { newValue in
            if newValue {
                curView = 2  // Transisi ke gameView saat permainan dimulai
            }
        }
    }
}


#Preview {
    PairViewContent(curView: .constant(0))
        .environmentObject(GameManager(username: "PreviewUser"))
}
