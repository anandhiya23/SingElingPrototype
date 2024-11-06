import SwiftUI


struct PairView: View {
    @Binding var curView: Int
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View{
        ZStack{
            Rectangle()
                .fill(Color.singElingZ50)
                .ignoresSafeArea()
            
            VStack{
                Text("Sing \nEling")
                    .multilineTextAlignment(.center)
                    .font(.custom("Skrapbook", size: 85))
                
                HintComponent(hintModel: HintModel(userRole: .mainView, readerName: ""), width: 300)
                    .padding()
                
                VStack {
                                    RoomComponent(roomModel: RoomModel(typeRoom: .createRoom), width: 200)
                                        .padding()
                                        .disabled(gameManager.isGuest || gameManager.isHost)
                                        .onTapGesture {
                                                                    // Set curView to 3 to navigate to PairViewContent immediately
                                                                    curView = 3
                                                                }
                                    
                                    RoomComponent(roomModel: RoomModel(typeRoom: .joinRoom), width: 200)
                                        .padding()
                                        .disabled(!gameManager.isHost)
                                        .onTapGesture {
                                                                    // Set curView to 3 to navigate to PairViewContent immediately
                                                                    curView = 3
                                                                }
                                }
                
                .padding(.horizontal, 50)
                .padding(.vertical, 10)
                
//                ScrollView {
//                    if gameManager.gameState.players.isEmpty{
//                        Spacer()
//                        HStack{
//                            Spacer()
//                            Text("Menunggu pemain lain...")
//                                .foregroundStyle(.singElingZ50)
//                            Spacer()
//                        }
//                        Spacer()
//                    }
//
//                    else {
//                                            UserJoinComponent(width: 300) // Using grid layout for players
//                                        }
//                    Spacer().padding(.bottom, 10)
//                    
//                    if gameManager.isHost{
//                        ForEach(gameManager.availablePeers, id: \.self) { peer in
//                            PairViewPendingListItem(peerName: peer.displayName)
//                                .simultaneousGesture(TapGesture().onEnded({ _ in
//                                    gameManager.serviceBrowser.invitePeer(peer, to: gameManager.session, withContext: nil, timeout: 30)
//                                }))
//                        }
//                    }
//                }
                if curView == 3 {
                    PairViewContent(curView: $curView)
                        .environmentObject(gameManager)
                }
            }
        }
        .onChange(of: gameManager.gameState.isPlaying) { oldValue, newValue in
            if newValue == true {
                curView = 2
            }
        }
    }
}
