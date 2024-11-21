import SwiftUI


struct ChoiceView: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View{
        ZStack{
            Image("Tikar Cream")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack{
//                Text("Sing \nEling")
//                    .multilineTextAlignment(.center)
//                    .font(.custom("Skrapbook", size: 85))
                
                HintComponent(hintModel: HintModel(userRole: .mainView, readerName: ""), width: 300)
                
                VStack {
                    RoomComponent(roomModel: RoomModel(typeRoom: .createRoom), width: 200)
                        .padding(.top)
                        .onTapGesture {
                            gameManager.curView = 2
                        }
                    
                    RoomComponent(roomModel: RoomModel(typeRoom: .joinRoom), width: 200)
                        .padding()
                        .disabled(!gameManager.isHost)
                        .onTapGesture {
                            gameManager.curView = 3
                        }
                }
                
                .padding(.horizontal, 50)
                .padding(.vertical, 10)
            }
        }
    }
}

#Preview {
    ChoiceView()
        .environmentObject(GameManager())
}
