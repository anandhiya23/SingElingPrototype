//
//  GameManager.swift
//  SingElingPrototype
//
//  Created by Bintang Anandhiya on 17/10/24.
//

import Foundation
import MultipeerConnectivity
import os
import SwiftUI
import Compression

//MARK: - MAIN GAME MANAGER
class GameManager: NSObject, ObservableObject{
    //MARK: Multipeer Connectivity Stored Properties
    public var myPeerID: MCPeerID!
    public var serviceAdvertiser: MCNearbyServiceAdvertiser!
    public var serviceBrowser: MCNearbyServiceBrowser!
    public var session: MCSession!
    private let serviceType = "bintang-service"
    private let log = Logger()
    
    private var advertisementRetryTimer: DispatchSourceTimer?
    private var previouslyConnectedPeers: [MCPeerID] = []
    private var invitationHandler: ((Bool, MCSession?) -> Void)?
    @Published var myUsername: String!
    @Published var availablePeers: [MCPeerID] = []
    @Published var availablePeersWithCode: [(MCPeerID, String)] = []
    var myPID: Int{
        gameState.players.firstIndex(where: { player in
            player.name == myUsername
        })!
    }
    @Published var myConnectivityStatus = 0
    @Published var myConnectivityType: ConnectivityType = .unknown
    @Published var curView: Int? = nil
    @Published var hostRoomCode: [Int] = []
    @Published var guestRoomCode: [Int] = []
    @Published var showDisconnectAlert: Bool = false
    
    //tambahin ini
    private let nameKey = "name"
    
    //    @Published var usernames: [String] = []
    @Published var isCodeValidated = false
    @Published var isPlaying: Bool = false
    
    var inputIdentifiers: [Int] = []
    
    @Published var winnerColor: Color = .black
    
    //background image berdasarkan user
    let backgroundImages = ["Tikar Biru", "Tikar Hijau", "Tikar Merah", "Tikar Oren"]
    
    
    var isConnected: Bool{
        self.myConnectivityStatus == 1 && self.myConnectivityType != .unknown
    }
    var isHost: Bool{
        self.myConnectivityType == .host
    }
    var isGuest: Bool{
        self.myConnectivityType == .guest
    }
    
    
    


    @Published var playingCards: [PlayingCard] = [ //tambahin @Published
        PlayingCard(text: "mangan jajan e konco tapi ora cuci tangan", indexNum: 1, backgroundCard: "Card1"),
        PlayingCard(text: "lali nggowo barang e konco pas arep mbalikno", indexNum: 2, backgroundCard: "Card2"),
        PlayingCard(text: "ora mbales chat e konco", indexNum: 3, backgroundCard: "Card3"),
        PlayingCard(text: "ora sengojo nyenggol konco sing lagi ngombe", indexNum: 4, backgroundCard: "Card4"),
        PlayingCard(text: "gak nyopo konco pas papasan", indexNum: 5, backgroundCard: "Card5"),
        PlayingCard(text: "ngguyu ndelok konco sing lagi kepleset", indexNum: 6, backgroundCard: "Card6"),
        PlayingCard(text: "nyilih jaket e konco, tapi gak sengojo ketumpahan banyu", indexNum: 7, backgroundCard: "Card7"),
        PlayingCard(text: "nyingit no hp e konco", indexNum: 8, backgroundCard: "Card8"),
        PlayingCard(text: "Pacaran ning ngarepe wong jomblo", indexNum: 9, backgroundCard: "Card9"),
        PlayingCard(text: "usil narik tali sepatu e konco", indexNum: 10, backgroundCard: "Card10"),
        PlayingCard(text: "mangan ning ngarepe wong sing lagi puasa", indexNum: 11, backgroundCard: "Card11"),
        PlayingCard(text: "sikile munggah kursi pas mangan ning omahe konco", indexNum: 12, backgroundCard: "Card12"),
        PlayingCard(text: "nyilih barang wek e konco tapi ora ijin", indexNum: 13, backgroundCard: "Card13"),
        PlayingCard(text: "julid i unggahan instagram e konco", indexNum: 14, backgroundCard: "Card14"),
        PlayingCard(text: "mangan jajan e konco tanpa ijin", indexNum: 15, backgroundCard: "Card15"),
        PlayingCard(text: "ngusili wong liyo pas sek mangan", indexNum: 16, backgroundCard: "Card16"),
        PlayingCard(text: "nyeluk uwong sambil mukul pundak e", indexNum: 17, backgroundCard: "Card17"),
        PlayingCard(text: "mangan karo ngecap banter", indexNum: 18, backgroundCard: "Card18"),
        PlayingCard(text: "mencet remot tv nggawe sikil ning ngarepe konco", indexNum: 19, backgroundCard: "Card19"),
        PlayingCard(text: "takon “kapan rabi” nang konco sing jomblo", indexNum: 20, backgroundCard: "Card20"),
        PlayingCard(text: "ngidek sepatu anyar e konco", indexNum: 21, backgroundCard: "Card21"),
        PlayingCard(text: "ngongkon konco tanpa ngomong “tulung”", indexNum: 22, backgroundCard: "Card22"),
        PlayingCard(text: "numplekno toples kong guan isi rengginang ning omah e konco", indexNum: 23, backgroundCard: "Card23"),
        PlayingCard(text: "komen julid ning sosmed e wong liyo", indexNum: 24, backgroundCard: "Card24"),
        PlayingCard(text: "mangan karo ngomong sampe muncrat", indexNum: 25, backgroundCard: "Card25"),
        PlayingCard(text: "Ngomong nggremeng nang abang ojek", indexNum: 26, backgroundCard: "Card26"),
        PlayingCard(text: "numplekno kopi ning klambi ne konco", indexNum: 27, backgroundCard: "Card27"),
        PlayingCard(text: "sengojo ngentut ning tempat umum", indexNum: 28, backgroundCard: "Card28"),
        PlayingCard(text: "ngentut buanter pas rapat", indexNum: 29, backgroundCard: "Card29"),
        PlayingCard(text: "ora ngucapno salam pas namu ning omahe wong liyo", indexNum: 30, backgroundCard: "Card30"),
        PlayingCard(text: "ora ngumbah sikil sak durunge munggah kasur e konco", indexNum: 31, backgroundCard: "Card31"),
        PlayingCard(text: "nyolong bulpen e konco", indexNum: 32, backgroundCard: "Card32"),
        PlayingCard(text: "nyenggol tangane lawan jenis sing mari wudhu", indexNum: 33, backgroundCard: "Card33"),
        PlayingCard(text: "nggibah ning bioskop", indexNum: 34, backgroundCard: "Card34"),
        PlayingCard(text: "nirukno suara e wong liyo berkali kali", indexNum: 35, backgroundCard: "Card35"),
        PlayingCard(text: "nyilih klambi e konco tapi ora dibalikno", indexNum: 36, backgroundCard: "Card36"),
        PlayingCard(text: "jajan gawe duwik kembalian belonjoan teko wong tuwo", indexNum: 37, backgroundCard: "Card37"),
        PlayingCard(text: "mondar mandir waktu mbak mu lagi nyapu", indexNum: 38, backgroundCard: "Card38"),
        PlayingCard(text: "nyeluk konco gawe jeneng e wong tuwo e", indexNum: 39, backgroundCard: "Card39"),
        PlayingCard(text: "glegeken banter ning ngarepe wong akeh", indexNum: 40, backgroundCard: "Card40"),
        PlayingCard(text: "sengojo nyerobot antrian ning tempat umum", indexNum: 41, backgroundCard: "Card41"),
        PlayingCard(text: "melotot nang wong sing gak dikenal", indexNum: 42, backgroundCard: "Card42"),
        PlayingCard(text: "nyombongno gaji pas pendekatan", indexNum: 43, backgroundCard: "Card43"),
        PlayingCard(text: "nganggo nada tinggi pas ngomong karo konco", indexNum: 44, backgroundCard: "Card44"),
        PlayingCard(text: "teko ning nikahan e wong sing gadikenal", indexNum: 45, backgroundCard: "Card45"),
        PlayingCard(text: "ngirim meme tanpa konteks nang grub keluarga sing lagi serius", indexNum: 46, backgroundCard: "Card46"),
        PlayingCard(text: "nyetel musik sampe tonggone budeg jam 2 isuk", indexNum: 47, backgroundCard: "Card47"),
        PlayingCard(text: "nyilih duwik 100 rb tapi ora dibalikno", indexNum: 48, backgroundCard: "Card48"),
        PlayingCard(text: "split bill tapi ora dibayar", indexNum: 49, backgroundCard: "Card49"),
        PlayingCard(text: "ngomong “ck’ pas dikongkon wong tuwo", indexNum: 50, backgroundCard: "Card50"),
        PlayingCard(text: "takon hal sing sensitif pas kencan pertama", indexNum: 51, backgroundCard: "Card51"),
        PlayingCard(text: "Mbukak paket konco sak penak e dewe", indexNum: 52, backgroundCard: "Card52"),
        PlayingCard(text: "buka whatsapp e konco tanpa ijin", indexNum: 53, backgroundCard: "Card53"),
        PlayingCard(text: "buka galeri hp e konco tanpa ijin", indexNum: 54, backgroundCard: "Card54"),
        PlayingCard(text: "ora njaluk sepuro pas nabrak wong liyo", indexNum: 55, backgroundCard: "Card55"),
        PlayingCard(text: "nggawe klambi seksi pas meeting ning kantor", indexNum: 56, backgroundCard: "Card56"),
        PlayingCard(text: "ngenyek konco sing lagi sinau bahasa inggris", indexNum: 57, backgroundCard: "Card57"),
        PlayingCard(text: "ngacungno jari tengah moro moro nang wong random", indexNum: 58, backgroundCard: "Card58"),
        PlayingCard(text: "turu pas dosen lagi jelasno materi", indexNum: 59, backgroundCard: "Card59"),
        PlayingCard(text: "ngenyek konco sing lagi sedih", indexNum: 60, backgroundCard: "Card60"),
        PlayingCard(text: "masak mi instan padahal ibuk wes masak", indexNum: 61, backgroundCard: "Card61"),
        PlayingCard(text: "ora ngomong matur suwun sak wis e dibantu", indexNum: 62, backgroundCard: "Card62"),
        PlayingCard(text: "njiplak tugas e konco", indexNum: 63, backgroundCard: "Card63"),
        PlayingCard(text: "ngeklaim kerjoan e wong liyo", indexNum: 64, backgroundCard: "Card64"),
        PlayingCard(text: "njupuk gorengan loro tapi mek dibayar siji", indexNum: 65, backgroundCard: "Card65"),
        PlayingCard(text: "nyilih motor e konco sampe bensin e entek", indexNum: 66, backgroundCard: "Card66"),
        PlayingCard(text: "njaluk tebengan karo pacar e konco", indexNum: 67, backgroundCard: "Card67"),
        PlayingCard(text: "nuker sepatu sing apik pas solat jumat", indexNum: 68, backgroundCard: "Card68"),
        PlayingCard(text: "Nyabut taneman e tonggo", indexNum: 69, backgroundCard: "Card69"),
        PlayingCard(text: "nyalahno konco ning ngarepe wong akeh", indexNum: 70, backgroundCard: "Card70"),
        PlayingCard(text: "nyilih barang tanpa ijin terus rusak", indexNum: 71, backgroundCard: "Card71"),
        PlayingCard(text: "telfonan romantis karo mbok e konco", indexNum: 72, backgroundCard: "Card72"),
        PlayingCard(text: "Selingkuh karo pacare konco", indexNum: 73, backgroundCard: "Card73"),
        PlayingCard(text: "Njaluk duit wong tuwo gawe dugem, padahal alesane gawe bayar SPP", indexNum: 74, backgroundCard: "Card74"),
        PlayingCard(text: "ngerokok sambil motoran terus kenek mripat e wong liyo", indexNum: 75, backgroundCard: "Card75"),
        PlayingCard(text: "moro-moro dolan ning omahe dosen bengi-bengi", indexNum: 76, backgroundCard: "Card76"),
        PlayingCard(text: "nelfon guru jam 2 isuk", indexNum: 77, backgroundCard: "Card77"),
        PlayingCard(text: "dulinan hp pas wong tuwo lagi ceramah", indexNum: 78, backgroundCard: "Card78"),
        PlayingCard(text: "nggudo arek wedok bengi bengi ing dalan", indexNum: 79, backgroundCard: "Card79"),
        PlayingCard(text: "Ngrumpi pas pengajian", indexNum: 80, backgroundCard: "Card80"),
        PlayingCard(text: "nyebarno berita hoax tentang guru nang arek sak angkatan", indexNum: 81, backgroundCard: "Card81"),
        PlayingCard(text: "ganggu ibadah e wong liyo", indexNum: 82, backgroundCard: "Card82"),
        PlayingCard(text: "motong pembicaraan e wong tuwo", indexNum: 83, backgroundCard: "Card83"),
        PlayingCard(text: "ngidu ning pinggir dalan terus ngenek i wong liyo", indexNum: 84, backgroundCard: "Card84"),
        PlayingCard(text: "nyawat mercon ning omah e tonggo", indexNum: 85, backgroundCard: "Card85"),
        PlayingCard(text: "ngelempar kotoran ning omah e tonggo", indexNum: 86, backgroundCard: "Card86"),
        PlayingCard(text: "ngenyek fisik e wong tuwo ning tempat umum", indexNum: 87, backgroundCard: "Card87"),
        PlayingCard(text: "ngerebut hak e wong liyo", indexNum: 88, backgroundCard: "Card88"),
        PlayingCard(text: "ngguyu ning pemakaman e wong liyo", indexNum: 89, backgroundCard: "Card89"),
        PlayingCard(text: "nyeluk wong tuwo gawe jeneng e", indexNum: 90, backgroundCard: "Card90"),
        PlayingCard(text: "misuh nang dosen pas bimbingan skirpsi", indexNum: 91, backgroundCard: "Card91"),
        PlayingCard(text: "misuh ning wong tuwo", indexNum: 92, backgroundCard: "Card92"),
        PlayingCard(text: "mbentak karo wong tuwo", indexNum: 93, backgroundCard: "Card93"),
        PlayingCard(text: "Nyuri duwik sumbangan", indexNum: 94, backgroundCard: "Card94"),
        PlayingCard(text: "ngeplak ndas e konco", indexNum: 95, backgroundCard: "Card95"),
        PlayingCard(text: "ngejek guru ning ngarep e kelas", indexNum: 96, backgroundCard: "Card96"),
        PlayingCard(text: "munggahno sikil ning ngarepe wong tuwo", indexNum: 97, backgroundCard: "Card97"),
        PlayingCard(text: "ndeleh sikil ning ndas e wong tuwo", indexNum: 98, backgroundCard: "Card98"),
        PlayingCard(text: "mukul wong tuwo ning tempat umum", indexNum: 99, backgroundCard: "Card99"),
        PlayingCard(text: "nyeleding sikil e guru sampe ceblok", indexNum: 100, backgroundCard: "Card100")
    ]
    
    @Published var gameState: GameState = GameState(){
        didSet{
            if isHost{
                //self.sendGameState(gameState)
            }
        }
    }

    //buat random warna di drag and drop
    var playerColors: [CodableColor] = [
        CodableColor(color: .singElingSB50),
        CodableColor(color: .singElingLC50),
        CodableColor(color: .singElingZ50),
        CodableColor(color: .singElingDSB50)
    ]
    
    // Mapping warna pemain ke background image
    let backgroundImageMapping: [CodableColor: String] = [
        CodableColor(color: .singElingSB50): "Tikar Oren",
        CodableColor(color: .singElingLC50): "Tikar Merah",
        CodableColor(color: .singElingZ50): "Tikar Hijau",
        CodableColor(color: .singElingDSB50): "Tikar Biru"
    ]
    
    func getBackgroundImage(for color: CodableColor) -> String {
        return backgroundImageMapping[color] ?? "SingElingDarkGreen" 
    }
    
    func clearTemporaryData() {
        let fileManager = FileManager.default
        let tempDir = fileManager.temporaryDirectory.path

        do {
            let tempFiles = try fileManager.contentsOfDirectory(atPath: tempDir)
            for file in tempFiles {
                let filePath = tempDir.appending("/\(file)")
                try fileManager.removeItem(atPath: filePath)
            }
            log.info("Temporary data cleared.")
        } catch {
            log.error("Failed to clear temporary data: \(error.localizedDescription)")
        }
    }


    
    public func initGuest(myUsername: String, discoveryInfo: [String: String]? = nil) {
        myPeerID = MCPeerID(displayName: myUsername)
        session = MCSession(peer: myPeerID, securityIdentity: nil, encryptionPreference: .none)
        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: discoveryInfo, serviceType: serviceType)
        
        session.delegate = self
        serviceAdvertiser.delegate = self
        clearTemporaryData()
        
        self.serviceAdvertiser.startAdvertisingPeer()
    }
    
    public func initHost(myUsername: String){
        myPeerID = MCPeerID(displayName: myUsername)
        session = MCSession(peer: myPeerID, securityIdentity: nil, encryptionPreference: .none)
        serviceBrowser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: serviceType)
        
        session.delegate = self
        serviceBrowser.delegate = self
        
        myConnectivityType = .host
        let color = playerColors[0]
        
        let hostPlayer = Player(name: myPeerID.displayName, color: color)
        gameState.players.append(hostPlayer)
        clearTemporaryData()
        
        serviceBrowser.startBrowsingForPeers()
    }
}

//MARK: - GAME FUNCTIONS
extension GameManager{
    var isGuesser: Bool{
        self.gameState.guesser_PID == self.myPID
    }
    var isReader: Bool{
        self.gameState.reader_PID == self.myPID
    }
    var readerName: String {
        if let reader = gameState.players.first(where: { $0.point == gameState.reader_PID }) {
            return reader.name
        }
        return "UNKNOWN READER"
    }
    var guesserName: String{
        gameState.players[gameState.guesser_PID].name
    }
    var pmode: Int{
        if isReader{
            return 2
        }else if isGuesser{
            return 1
        }else{
            return 0
        }
    }
    var guesserCards: [Int]{
        return gameState.players[gameState.guesser_PID].playingCards_CID
    }
    var guesserCardPos: Int{
        return gameState.players[gameState.guesser_PID].cardPos
    }
    var myCards: [Int]{
        return gameState.players[myPID].playingCards_CID
    }
    var myCardPos: Int{
        return gameState.players[myPID].cardPos
    }
    var readerCardText: String{
        return playingCards[gameState.readerCard_CID].text
    }
    var readerCardIndexNum: Int{
        return playingCards[gameState.readerCard_CID].indexNum
    }
    
    var readerCardBackground: String{
        return playingCards[gameState.readerCard_CID].backgroundCard
    }
    
    var triggerGuesserCardShift: Bool{
        gameState.triggerGuesserCardShift
    }
    var winnerName: String{
        guard gameState.winner_PID != nil else {
            return "ERROR NO WINNER YET"
        }
        return gameState.players[gameState.winner_PID!].name
    }
    
    func myCardPosShiftLeft(){
        //TRY TO MAKE IT ALL THE TIME FIRST
        if isHost{
            gameState.players[myPID].cardPos = min(gameState.players[myPID].cardPos + 1, gameState.players[myPID].playingCards_CID.count)
            gameState.triggerGuesserCardShift.toggle()
            sendGameState(gameState)
        }else if isGuest{
            sendGameCommand(GameCommand(.cardPosShiftLeft, intData: myPID))
        }
    }
    
    func myCardPosShiftRight(){
        if isHost{
            gameState.players[myPID].cardPos = max(gameState.players[myPID].cardPos - 1, 0)
            gameState.triggerGuesserCardShift.toggle()
            sendGameState(gameState)
        }else if isGuest{
            sendGameCommand(GameCommand(.cardPosShiftRight, intData: myPID))
        }
        
    }
    
    func makeGuess(){
        guard isGuesser else{
            log.warning("Only guessser can make guess")
            return
        }
        if isHost{
            nextTurn()
        }else if isGuest{
            sendGameCommand(GameCommand(.invokeNextTurn))
        }
    }
    //USERNAME SAVING BY HALIZA
//    //tambahin ini
//    func updateUsername(_ newUsername: String) {
//        self.username = newUsername
//    }
//    
//    func addPlayer(name: String) {
//        let newPlayer = Player(name: name)
//        gameState.players.append(newPlayer)
//        sendGameState(gameState)  // Jika perlu sinkronisasi ke pemain lain
//    }
//    
//    // Fungsi untuk menyimpan nama pengguna ke UserDefaults
//    func saveNameToDefaults(_ name: String) {
//        UserDefaults.standard.set(name, forKey: nameKey)
//        print("Username \(name) berhasil disimpan pada UserDefaults")
//    }
//    
//    // Fungsi untuk mengambil nama pengguna dari UserDefaults
//    func getNameFromDefaults() -> String {
//        let savedName = UserDefaults.standard.string(forKey: nameKey) ?? ""
//        print("Username \(savedName) berhasil diambil dari UserDefaults")
//        return savedName
//    }
//    
//    // Fungsi untuk menghapus nama pengguna dari UserDefaults
//    func clearSavedName() {
//        UserDefaults.standard.removeObject(forKey: nameKey)
//        username = ""
//        //        usernames = [] // Setel username kosong
//        print("Username berhasil dihapus dari UserDefaults")
//    }
    
    // Fungsi untuk menyimpan kode room jika player adalah host
    func generateRoomCode(colors: [Color], images: [String]) {
        guard isHost else {
            print("Bukan host, tidak bisa menghasilkan kode room.")
            return
        }
        
        // Shuffle and select icons for the room code
        let selectedIcons = roomIcons.shuffled().prefix(4)
        let identifiers = selectedIcons.map { $0.iconID }
        let iconNames = selectedIcons.map { $0.iconName }
        
//        gameState.roomIdentifiers = identifiers
//        gameState.roomImages = iconNames

        print("Generated room code identifiers: \(identifiers)")
        print("Generated room images: \(iconNames)")
        
//        print("Sending room identifiers to guest: \(gameState.roomIdentifiers)")
        sendGameState(gameState)
    }
    
    func setGuestInputIdentifiers(_ identifiers: [Int]) {
        self.inputIdentifiers = identifiers
    }
    
    //MARK: - Host Only Functions
    func startGame(){
        guard isHost else{
            log.warning("Only host can start game")
            return
        }
        gameState.availablePlayingCards_CID = Array(0..<playingCards.count)
        gameState.availablePlayingCards_CID.shuffle()
        for PID in gameState.players.indices{
            let STARTING_CARDS_AMMOUNT = 1
            gameState.players[PID].playingCards_CID = Array(gameState.availablePlayingCards_CID.prefix(STARTING_CARDS_AMMOUNT)).sorted(by: <)
            gameState.availablePlayingCards_CID.removeFirst(STARTING_CARDS_AMMOUNT)
            gameState.players[PID].cardPos = 0
            gameState.players[PID].point = 0
        }
        gameState.winner_PID = nil
        gameState.readerCard_CID = gameState.availablePlayingCards_CID[0]
        gameState.availablePlayingCards_CID.removeFirst()
        gameState.isPlaying = true
        sendGameState(gameState)
    }
    
    func guesserIsCorrect(){
        gameState.players[gameState.guesser_PID].point += 1
        gameState.players[gameState.guesser_PID].playingCards_CID.insert(gameState.readerCard_CID, at: guesserCardPos)
        gameState.players[gameState.guesser_PID].cardPos += 1
        if gameState.players[gameState.guesser_PID].point >= 4{
            gameState.winner_PID = gameState.guesser_PID
        }
    }
    
    func checkGuess() -> Bool{
        var guessCorrect = false
        let guesser = gameState.players[gameState.guesser_PID]
        let selectedCard = playingCards[gameState.readerCard_CID]
        let guesserCardPos = guesser.cardPos
        
        if guesserCardPos == 0{
            let rightCard_CID = guesser.playingCards_CID[guesserCardPos]
            
            if selectedCard.indexNum <= playingCards[rightCard_CID].indexNum{
                guesserIsCorrect()
                guessCorrect = true
            }
        }else if guesserCardPos == guesser.playingCards_CID.count{
            let leftCard_CID = guesser.playingCards_CID[guesserCardPos - 1]
            
            if selectedCard.indexNum >= playingCards[leftCard_CID].indexNum{
                guesserIsCorrect()
                guessCorrect = true
            }
        }else{
            let leftCard_CID = guesser.playingCards_CID[guesserCardPos - 1]
            let rightCard_CID = guesser.playingCards_CID[guesserCardPos]
            
            if selectedCard.indexNum >= playingCards[leftCard_CID].indexNum && selectedCard.indexNum <= playingCards[rightCard_CID].indexNum{
                guesserIsCorrect()
                guessCorrect = true
            }
        }
        
        sendGameState(gameState)
        return guessCorrect
    }
    
    func nextTurn(){
        guard isHost else{
            log.warning("Only host can start game")
            return
        }
        let guessResult = checkGuess()
        gameState.isCorrect = guessResult
        sendGameCommand(GameCommand(.hideOthersCards, boolData: guessResult))
        withAnimation {
            gameState.othersCardsHidden = true
        }
        gameState.guesserName = gameState.players[gameState.guesser_PID].name
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){ [self] in
            gameState.guesser_PID = (gameState.guesser_PID + 1) % gameState.players.count
            if gameState.guesser_PID == gameState.reader_PID || guessResult == true{
                //NEW READER
                gameState.reader_PID = (gameState.reader_PID + 1) % gameState.players.count
                gameState.guesser_PID = (gameState.reader_PID + 1) % gameState.players.count
                gameState.readerCard_CID = gameState.availablePlayingCards_CID[0]
                gameState.availablePlayingCards_CID.removeFirst()
            }
//            withAnimation {
                gameState.announcementGame = true
//            }
            sendGameState(gameState)
            //print("Reader: \(gameManager.gameState.reader_PID) Guesser: \(gameManager.gameState.guesser_PID)")
            sendGameCommand(GameCommand(.showOthersCards))
            withAnimation {
                gameState.othersCardsHidden = false
            }
        }
    }
}

//MARK: - MC FUNCTIONS
extension GameManager{
    
    func disconnectSession() {
        session.disconnect()
        log.info("Session disconnected")
    }

    
    func compress(data: Data) -> Data? {
        let bufferSize = 64 * 1024 // 64 KB
        var compressedData = Data()
        
        let destinationBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        defer { destinationBuffer.deallocate() }
        
        data.withUnsafeBytes { srcPointer in
            guard let srcBaseAddress = srcPointer.baseAddress else { return }
            
            let srcBuffer = UnsafeBufferPointer(start: srcBaseAddress.assumingMemoryBound(to: UInt8.self), count: data.count)
            
            let compressedSize = compression_encode_buffer(
                destinationBuffer,
                bufferSize,
                srcBuffer.baseAddress!,
                srcBuffer.count,
                nil,
                COMPRESSION_ZLIB
            )
            
            if compressedSize > 0 {
                compressedData.append(destinationBuffer, count: compressedSize)
            }
        }
        
        return compressedData
    }
    
    func decompress(data: Data) -> Data? {
        let bufferSize = 64 * 1024 // 64 KB
        var decompressedData = Data()

        let destinationBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        defer { destinationBuffer.deallocate() }

        data.withUnsafeBytes { srcPointer in
            guard let srcBaseAddress = srcPointer.baseAddress else { return }

            let srcBuffer = UnsafeBufferPointer(start: srcBaseAddress.assumingMemoryBound(to: UInt8.self), count: data.count)

            let decompressedSize = compression_decode_buffer(
                destinationBuffer,
                bufferSize,
                srcBuffer.baseAddress!,
                srcBuffer.count,
                nil,
                COMPRESSION_ZLIB
            )

            if decompressedSize > 0 {
                decompressedData.append(destinationBuffer, count: decompressedSize)
            }
        }

        return decompressedData
    }

    
    func sendGameState(_ gameState: GameState) {
        // Pastikan ada peers yang terhubung
        if !session.connectedPeers.isEmpty {
            log.info("Sending GameState to connected peers.")
            
            do {
                // Membuat objek SendableGameData dengan gameState yang ingin dikirim
                let sendableData = SendableGameData(type: .gameState, gameState: gameState, sender_PID: myPID)
                
                // Encode objek menjadi Data untuk dikirimkan
                let encoder = JSONEncoder()
                let encodedData = try encoder.encode(sendableData)
                
                if let compressedData = compress(data: encodedData) {
                    try session.send(compressedData, toPeers: session.connectedPeers, with: .reliable)
                    log.warning("Compressed GameState sent (\(compressedData.count) bytes).")
                    for peer in session.connectedPeers {
                        log.warning("Data sent: \(compressedData.count) bytes to \(peer.displayName)")
                    }
                } else {
                    log.error("Failed to compress GameState.")
                }
                
//                print("Host is sending gameState with room identifiers: \(gameState.roomIdentifiers)")
                
                
//                try session.send(encodedData, toPeers: session.connectedPeers, with: .reliable)
//                log.info("GameState successfully sent to \(self.session.connectedPeers.count) peers.")
                
            } catch {
                // Tangani error jika pengiriman gagal
                log.error("Failed to send GameState: \(error.localizedDescription)")
            }
        } else {
            log.warning("No peers connected. Unable to send GameState.")
        }
    }
    
    func sendRoomIconsToPeers() {
        do {
            let data = try JSONEncoder().encode(roomIcons)
            
            // Menambahkan `try` pada pemanggilan fungsi `session.send`
            try session.send(data, toPeers: session.connectedPeers, with: .reliable)
            
            print("Room icons sent!")
        } catch {
            print("Failed to send room icons: \(error)")
        }
    }
    
    func sendGameCommand(_ gameCommand: GameCommand) {
        if !session.connectedPeers.isEmpty {
            log.info("Sending GameCommand to connected peers")
            do {
                // Encode the GameCommand to JSON
                let encoder = JSONEncoder()
                let gameData = SendableGameData(type: .gameCommand, gameCommand: gameCommand, sender_PID: myPID)
                let encodedData = try encoder.encode(gameData)
                
                // Compress the encoded data
                if let compressedData = compress(data: encodedData) {
                    // Send compressed data
                    try session.send(compressedData, toPeers: session.connectedPeers, with: .reliable)
                    log.info("GameCommand sent successfully (compressed data size: \(compressedData.count) bytes)")
                } else {
                    log.error("Failed to compress the game command data.")
                }
            } catch {
                log.error("Error sending: \(String(describing: error))")
            }
        }
    }

    func sendGameCommand(_ gameCommand: GameCommand, to targetPeerID: MCPeerID) {
        if !session.connectedPeers.isEmpty {
            log.info("Sending GameCommand to specific peer: \(targetPeerID.displayName)")
            do {
                // Encode the GameCommand to JSON
                let encoder = JSONEncoder()
                let gameData = SendableGameData(type: .gameCommand, gameCommand: gameCommand, sender_PID: myPID)
                let encodedData = try encoder.encode(gameData)
                
                // Compress the encoded data
                if let compressedData = compress(data: encodedData) {
                    // Send compressed data to a specific peer
                    try session.send(compressedData, toPeers: [targetPeerID], with: .reliable)
                    log.info("GameCommand sent successfully (compressed data size: \(compressedData.count) bytes)")
                } else {
                    log.error("Failed to compress the game command data.")
                }
            } catch {
                log.error("Error sending: \(String(describing: error))")
            }
        }
    }
}

//MARK: - SERVICE ADVERTISER (GUEST)
extension GameManager: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        //TODO: Inform the user something went wrong and try again
        log.error("ServiceAdvertiser didNotStartAdvertisingPeer: \(String(describing: error))")
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        log.info("didReceiveInvitationFromPeer \(peerID.displayName)")
        // Dekode data context jika ada
        if let context = context {
            do {
                let roomIcons = try JSONDecoder().decode([RoomIconModel].self, from: context)
                log.info("Received Room Icons: \(roomIcons)")
                // Simpan atau gunakan roomIcons sesuai kebutuhan
            } catch {
                log.error("Failed to decode room icons: \(error)")
            }
        }
        
        DispatchQueue.main.async {
            //TODO: Use alerts when joining and affirming to invitations
            invitationHandler(true, self.session)
        }
    }

    
}

//MARK: - SERVICE BROWSER (HOST)
extension GameManager: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        log.error("ServiceBroser didNotStartBrowsingForPeers: \(String(describing: error))")
    }
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        // Add the peer to the list of available peers
        if gameState.players.contains(where: {$0.name == peerID.displayName}){
            log.info("Host's service browser found previous peer: \(peerID.displayName)")
            serviceBrowser.invitePeer(peerID, to: session, withContext: nil, timeout: 7)
        }else{
            log.info("Host's service browser found new peer: \(peerID)")
        }
        
        DispatchQueue.main.async {
            self.availablePeers.append(peerID)
        }
        
        if let advertisedInfo = info{
            if let advertisedRoomCode = advertisedInfo["code"]{
                let advertisedRoomCodeArray = advertisedRoomCode.split(separator: ",").compactMap({ Int($0) })
                if advertisedRoomCodeArray == hostRoomCode{
                    serviceBrowser.invitePeer(peerID, to: session, withContext: nil, timeout: 7)
                }
            }
        }
        
    }
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        log.info("Host's service browser lost peer: \(peerID.displayName)")
        // Remove lost peer from list of available peers
        DispatchQueue.main.async {
            self.availablePeers.removeAll(where: {
                $0 == peerID
            })
        }
    }
}

//MARK: - SESSION DELEGATE (HOST & GUEST)
extension GameManager: MCSessionDelegate {
    //MARK: Received Game Data
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        log.info("peer \(peerID.displayName) didChangeState: \(state.rawValue)")
        
        switch state {
        case MCSessionState.notConnected: //JUST DISCONNECTED <<<<<<<<<<<<<<<<<<<<<<<<<
            // Peer disconnected
            DispatchQueue.main.async { [self] in
                if isHost {
                    showDisconnectAlert = true
                    if session.connectedPeers.isEmpty {
                        log.info("All peers disconnected. Cleaning up session.")
                        disconnectSession()
                    }
                } else {
                    log.info("Attempting to re-advertise as \(peerID.displayName)")
                    stopAdvertisementRetry() // Cancel any existing retry timer before starting a new one
                    startAdvertisementRetry() // Start a repeating timer to re-advertise every 4 seconds
                    showDisconnectAlert = true
                }
            }
            break
            
        case MCSessionState.connected: //JUST CONNECTED <<<<<<<<<<<<<<<<<<<<<<<<<
            if isHost{
                if let PID = gameState.players.firstIndex(where: {$0.name == peerID.displayName}){
                    sendGameCommand(GameCommand(.assignPID, intData: PID), to: peerID)
                    sendGameState(gameState)
                }else{
                    DispatchQueue.main.async{ [self] in
//                        let backgroundImage = backgroundImages[gameState.players.count]
                        let color = playerColors[gameState.players.count]
                              
                        sendGameCommand(GameCommand(.assignPID, intData: gameState.players.count), to: peerID)
                        gameState.players.append(Player(name: peerID.displayName, color: color))
                        sendGameState(gameState)
                    }
                }
                showDisconnectAlert = false

            }else{
                DispatchQueue.main.async {
                    //                    self.paired = true
                    self.myConnectivityType = .guest
                }
                
                // We are paired, stop advertising and stop the retry timer
                serviceAdvertiser.stopAdvertisingPeer()
                self.stopAdvertisementRetry()
                showDisconnectAlert = false

            }
            break
            
            
        case .connecting:
            log.info("\(peerID.displayName) is connecting.")
            
        default:
            // Peer connecting or something else
            DispatchQueue.main.async {
                //                self.paired = false
            }
            break
        }
    }
    
    //MARK: Advertisement Retry
    func startAdvertisementRetry() {
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.main)
        timer.schedule(deadline: .now(), repeating: 10.0)
        timer.setEventHandler {
            self.log.info("Re-advertising as: \(self.myPeerID.displayName)")
            self.serviceAdvertiser.stopAdvertisingPeer()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.serviceAdvertiser.startAdvertisingPeer()
            }
        }
        self.advertisementRetryTimer = timer
        timer.resume()
    }
    func stopAdvertisementRetry() {
        self.advertisementRetryTimer?.cancel()
        self.advertisementRetryTimer = nil
    }
    
    //MARK: Receive Data
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        // Attempt to decompress the received data
        if let decompressedData = decompress(data: data) {
            let decoder = JSONDecoder()
            do {
                // Decode the decompressed data into SendableGameData
                let receivedGameData = try decoder.decode(SendableGameData.self, from: decompressedData)
                log.info("Did receive SendableGameData from \(peerID.displayName)")

                DispatchQueue.main.async {
                    // Handle the data based on whether it's the host or guest
                    if self.isHost {
                        self.handleReceivedGameDataHost(receivedGameData, fromPeerID: peerID)
                    } else if self.isGuest {
                        self.handleReceivedGameDataGuest(receivedGameData, fromPeerID: peerID)
                    }
                }
            } catch {
                log.error("Failed to decode decompressed data: \(error.localizedDescription)")
            }
        } else {
            log.error("Failed to decompress received data from \(peerID.displayName).")
        }
    }
    
    //MARK: Unused MCSessionDelegate Functions
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        log.error("Receiving streams is not supported")
    }
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        log.error("Receiving resources is not supported")
    }
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        log.error("Receiving resources is not supported")
    }
    public func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) {
        certificateHandler(true)
    }
    
    //MARK: - Handle Received Game Data
    private func handleReceivedGameDataHost(_ receivedGameData: SendableGameData, fromPeerID: MCPeerID){
        if receivedGameData.type == .gameState{
            
        }else if receivedGameData.type == .gameCommand{
            if let newGameCommand = receivedGameData.gameCommand{
                switch newGameCommand.command{
                case .cardPosShiftLeft:
                    let tempPID = newGameCommand.intData!
                    gameState.players[tempPID].cardPos = min(gameState.players[tempPID].cardPos + 1, gameState.players[tempPID].playingCards_CID.count)
                    gameState.triggerGuesserCardShift.toggle()
                    sendGameState(gameState)
                    break
                case .cardPosShiftRight:
                    let tempPID = newGameCommand.intData!
                    gameState.players[tempPID].cardPos = max(gameState.players[tempPID].cardPos - 1, 0)
                    gameState.triggerGuesserCardShift.toggle()
                    sendGameState(gameState)
                    break
                case .invokeNextTurn:
                    nextTurn()
                    break
                default:
                    log.warning("Unknown recieved game command (Host)")
                }
                
            }else{
                log.warning("Sendable game data identify as game command but does not specify command (Host)")
            }
        }
    }
    
    private func handleReceivedGameDataGuest(_ receivedGameData: SendableGameData, fromPeerID: MCPeerID){
        if receivedGameData.type == .gameState{
            if let newGameState = receivedGameData.gameState{
                gameState = newGameState
            }else{
                log.warning("Sendable game data identify as game state but does not have game state (Guest)")
            }
        }else if receivedGameData.type == .gameCommand{
            if let newGameCommand = receivedGameData.gameCommand{
                switch newGameCommand.command{
                case .assignPID:
//                    myPID = newGameCommand.intData!
                    break
                case .hideOthersCards:
                    if receivedGameData.gameCommand?.boolData ?? false{
                        playSoundResultCorrect()
                    }else{
                        playSoundResultWrong()
                    }
                    withAnimation {
                        gameState.othersCardsHidden = true
                    }
                    break
                case .showOthersCards:
                    withAnimation{
                        gameState.othersCardsHidden = false
                    }
                    break
                default:
                    log.warning("Unknown recieved game command (Guest)")
                }
            }else{
                log.warning("Sendable game data identify as game command but does not specify command (Guest)")
            }
        }
    }
}
