import SwiftUI


struct PairView: View {
    @Binding var curView: Int
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View{
        ZStack{
//            Rectangle()
//                .fill(Color.singElingZ50)
//                .ignoresSafeArea()
            Image("Tikar Cream")
                .resizable()
                .ignoresSafeArea()
            VStack{
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

#Preview{
    PairView(curView: .constant(0))
        .environmentObject(GameManager(username: "hhh"))
}
