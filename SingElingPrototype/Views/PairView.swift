import SwiftUI


struct PairView: View {
    @Binding var curView: Int
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View{
        VStack{
            HStack(alignment: .center) {
                Button("Buka Ruangan") {
                    gameManager.becomeHost()
                }
                .buttonStyle(GrowingButton())
                .disabled(gameManager.isGuest || gameManager.isHost)
                Spacer()
                Button("\(Image(systemName: "play.fill")) Mulai"){
                    gameManager.startGame()
                }
                .buttonStyle(GrowingButton())
                .disabled(!gameManager.isHost)
                
            }
            .padding(.horizontal, 50)
            .padding(.vertical, 10)
            
            ScrollView {
                if gameManager.gameState.players.isEmpty{
                    Spacer()
                    HStack{
                        Spacer()
                        Text("Menunggu pemain lain...")
                            .foregroundStyle(.black)
                        Spacer()
                    }
                    Spacer()
                }
                ForEach(gameManager.gameState.players, id: \.self) { player in
                    HStack{
                        Spacer()
                        HStack{
                            Text("\(player.name)")
                                .font(.title2)
                                .foregroundColor(.black)
                                .bold()
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(width: 300, height: 80)
                    .background{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.green)
                            .strokeBorder(.black, lineWidth: 3)
                    }
                }
                
                Spacer().padding(.bottom, 10)
                
                if gameManager.isHost{
                    ForEach(gameManager.availablePeers, id: \.self) { peer in
                        PairViewPendingListItem(peerName: peer.displayName)
                            .simultaneousGesture(TapGesture().onEnded({ _ in
                                gameManager.serviceBrowser.invitePeer(peer, to: gameManager.session, withContext: nil, timeout: 30)
                            }))
                    }
                }
            }
        }
        .onChange(of: gameManager.gameState.isPlaying) { oldValue, newValue in
            if newValue == true{
                curView = 2
            }
        }
    }
}
