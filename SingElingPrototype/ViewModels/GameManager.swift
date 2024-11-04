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

//MARK: - MAIN GAME MANAGER
class GameManager: NSObject, ObservableObject{
    //MARK: Multipeer Connectivity Stored Properties
    public let myPeerID: MCPeerID
    public let serviceAdvertiser: MCNearbyServiceAdvertiser
    public let serviceBrowser: MCNearbyServiceBrowser
    public let session: MCSession
    private let serviceType = "bintang-service"
    private let log = Logger()
    private var advertisementRetryTimer: DispatchSourceTimer?
    private var previouslyConnectedPeers: [MCPeerID] = []
    private var invitationHandler: ((Bool, MCSession?) -> Void)?
    @Published var availablePeers: [MCPeerID] = []
    @Published var myPID: Int = -1
    @Published var myConnectivityStatus = 0
    @Published var myConnectivityType: ConnectivityType = .unknown
    
    //tambahin ini
    private let nameKey = "name"
    
    @Published var usernames: [String] = []
    
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
        PlayingCard(text: "Ora ngomong matur suwun sak wis e dibantu", indexNum: 1),
        PlayingCard(text: "Ora ngucapno salam pas namu ning omahe wong liyo", indexNum: 2),
        PlayingCard(text: "Ora mbales sapaan", indexNum: 3),
        PlayingCard(text: "Lali nggowo barang wek e konco pas arep mbalikno", indexNum: 4),
        PlayingCard(text: "Nyilih jaket e konco, tapi gak sengojo ketumpahan banyu", indexNum: 5),
        PlayingCard(text: "Gak nyopo konco pas papasan", indexNum: 6),
        PlayingCard(text: "Sikile munggah kursi pas mangan ning omahe konco", indexNum: 7),
        PlayingCard(text: "Nyilih barang wek e konco tapi ora ijin", indexNum: 8),
        PlayingCard(text: "Buka galeri hp e konco tanpa ijin", indexNum: 9),
        PlayingCard(text: "Buka whatsapp e konco tanpa ijin", indexNum: 10),
        PlayingCard(text: "Mangan jajan e konco tanpa ijin", indexNum: 11),
        PlayingCard(text: "Nyeluk uwong sambil mukul pundak e", indexNum: 12),
        PlayingCard(text: "Nyenggol tangan e wong sing lagi ngombe", indexNum: 13),
        PlayingCard(text: "Nganggo nada tinggi pas ngomong", indexNum: 14),
        PlayingCard(text: "Mangan karo ngecap", indexNum: 15),
        PlayingCard(text: "Narik tali sepatu wong liyo", indexNum: 16),
        PlayingCard(text: "Nyilih klambi e konco tapi ora dibalikno", indexNum: 17),
        PlayingCard(text: "Tuku jajan gawe duwik kembalian sing dikek i wong tuwo gawe tuku sayur", indexNum: 18),
        PlayingCard(text: "Nyeluk konco gawe jeneng e wong tuwo e", indexNum: 19),
        PlayingCard(text: "Ngomong e koyok nggremeng", indexNum: 20),
        PlayingCard(text: "Ngomon 'ck' pas dikongkon wong tuwo", indexNum: 21),
        PlayingCard(text: "Meloto ke wong sing gak dikenal", indexNum: 22),
        PlayingCard(text: "Ngirim meme tanpa konteks sing jelas nang grub keluarga sing lagi serius", indexNum: 23),
        PlayingCard(text: "Nyetel musik sampe tonggone budeg", indexNum: 24),
        PlayingCard(text: "Nyilih duwik tapi ora dibalikno", indexNum: 25),
        PlayingCard(text: "Split bill tapi ora dibayar", indexNum: 26),
        PlayingCard(text: "Flexing pas pdkt", indexNum: 27),
        PlayingCard(text: "Takon hal sing sensitif pas first date", indexNum: 28),
        PlayingCard(text: "Numplekno kopi ning klambi ne konco", indexNum: 29),
        PlayingCard(text: "Nyingitno hp e konco", indexNum: 30),
        PlayingCard(text: "Ngeklaim kerjoan e wong liyo", indexNum: 31),
        PlayingCard(text: "Ngongkon konco tanpa ngomong 'tolong'", indexNum: 32),
        PlayingCard(text: "Nirukno suara e wong liyo berkali kali", indexNum: 33),
        PlayingCard(text: "Nyolong bulpen e konco", indexNum: 34),
        PlayingCard(text: "Mbukak paket konco tanpa ngomong", indexNum: 35),
        PlayingCard(text: "Ngguyu ning pemakaman e wong liyo", indexNum: 36),
        PlayingCard(text: "Nyenggol tangane konco wadon sing lagi wudhu", indexNum: 37),
        PlayingCard(text: "Ora njaluk sepuro pas gak sengojo nabrak wong liyo", indexNum: 38),
        PlayingCard(text: "Pacaran ning ngarepe wong jomblo", indexNum: 39),
        PlayingCard(text: "Komen julid ning sosmed e wong liyo", indexNum: 40),
        PlayingCard(text: "Ora ngumbah sikil sak durunge munggah kasur e konco", indexNum: 41),
        PlayingCard(text: "Ngidek sepatu anyar e konco", indexNum: 42),
        PlayingCard(text: "Nyeleding sikil e guru", indexNum: 43),
        PlayingCard(text: "Nggawe klambi seksi pas meeting ning kantor", indexNum: 44),
        PlayingCard(text: "Masak mi instan padahal ibuk wes masak", indexNum: 45),
        PlayingCard(text: "Takon 'kapan nikah' nang konco sing jomblo", indexNum: 46),
        PlayingCard(text: "Teko ning nikahan e wong sing gadikenal, terus mangan sampe wareg", indexNum: 47),
        PlayingCard(text: "Julid i story instagram e konco", indexNum: 48),
        PlayingCard(text: "Ngenyek konco sing lagi sinau bahasa inggris", indexNum: 49),
        PlayingCard(text: "Ngelempar mercon ning omah e tonggo", indexNum: 50),
        PlayingCard(text: "Mondar mandir waktu mbak mu lagi nyapu", indexNum: 51),
        PlayingCard(text: "Ngajak pacar e konco nonton bioskop tanpa ngomong", indexNum: 52),
        PlayingCard(text: "Ngacungno jari tengah moro moro nang wong random", indexNum: 53),
        PlayingCard(text: "Nyilih motor e konco sampe bensin e entek", indexNum: 54),
        PlayingCard(text: "Njaluk tebengan karo pacar e konco", indexNum: 55),
        PlayingCard(text: "Nuker sepatu sing apik pas solat jumat", indexNum: 56),
        PlayingCard(text: "Numplekno toples kong guan isi rengginang ning omah e konco", indexNum: 57),
        PlayingCard(text: "Selingkuh karo pacare konco", indexNum: 58),
        PlayingCard(text: "Ngguyu ndelok konco sing mari ceblok", indexNum: 59),
        PlayingCard(text: "Njaluk sangu wong tuwo digawe dugem padahal ngomong e gawe bayar spp", indexNum: 60),
        PlayingCard(text: "Nyeluk wong tuwo gawe jeneng e langsung", indexNum: 61),
        PlayingCard(text: "Ngerokok sambil motoran terus kenek mripat e wong liyo", indexNum: 62),
        PlayingCard(text: "Dolan ning omahe dosen bengi-bengi", indexNum: 63),
        PlayingCard(text: "Nelfon guru jam 2 isuk", indexNum: 64),
        PlayingCard(text: "Nyuri duwik sumbangan", indexNum: 65),
        PlayingCard(text: "Nyontek ujian", indexNum: 66),
        PlayingCard(text: "Njupuk gorengan 2 tapi mek dibayar 1", indexNum: 67),
        PlayingCard(text: "Mbentak karo wong tuwo", indexNum: 68),
        PlayingCard(text: "Mangan tapi ora cuci tangan", indexNum: 69),
        PlayingCard(text: "Nyolong sandangane konco pas dolan ning omah e", indexNum: 70),
        PlayingCard(text: "Nyawat mercon ning omah e tonggo", indexNum: 71),
        PlayingCard(text: "Ngejek guru ning ngarep e kelas", indexNum: 72),
        PlayingCard(text: "Mangan karo ngomong", indexNum: 73),
        PlayingCard(text: "Mangan ning ngarepe wong sing lagi puasa", indexNum: 74),
        PlayingCard(text: "Nyalahno konco ning ngarepe wong akeh", indexNum: 75),
        PlayingCard(text: "Turu pas dosen lagi jelasno materi", indexNum: 76),
        PlayingCard(text: "Misuh nang dosen pas bimbingan skirpsi", indexNum: 77),
        PlayingCard(text: "Misuh ning wong tuwo", indexNum: 78),
        PlayingCard(text: "Dulinan hp pas wong tuwo lagi ceramah", indexNum: 79),
        PlayingCard(text: "Nyilih barang tanpa ijin terus rusak", indexNum: 80),
        PlayingCard(text: "Catcalling", indexNum: 81),
        PlayingCard(text: "Nyebarno berita hoax", indexNum: 82),
        PlayingCard(text: "Nggibah ning bioskop", indexNum: 83),
        PlayingCard(text: "Ganggu ibadah e wong liyo", indexNum: 84),
        PlayingCard(text: "Glegeken banter ning ngarepe wong akeh", indexNum: 85),
        PlayingCard(text: "Ngenyek wong tuwo", indexNum: 86),
        PlayingCard(text: "Ngeplak ndas e konco utowo wong tuwo", indexNum: 87),
        PlayingCard(text: "Ngidu ning pinggir dalan terus ngenek i wong liyo", indexNum: 88),
        PlayingCard(text: "Munggahno sikil ning ngarepe wong tuwo", indexNum: 89),
        PlayingCard(text: "Sengojo nyerobot antrian ning tempat umum", indexNum: 90),
        PlayingCard(text: "Motong pembicaraan e wong tuwo", indexNum: 91),
        PlayingCard(text: "Ngentut buanter ning tengah diskusi", indexNum: 92),
        PlayingCard(text: "Ndeleh sikil ning ndas e wong tuwo", indexNum: 93),
        PlayingCard(text: "Ganggu wong liyo pas sek mangan", indexNum: 94),
        PlayingCard(text: "Ngenyek konco sing lagi sedih", indexNum: 95),
        PlayingCard(text: "Sengojo ngentut ning tempat umum", indexNum: 96),
        PlayingCard(text: "Ngenyek fisik e wong tuwo ning tempat umum", indexNum: 97),
        PlayingCard(text: "Ngerebut hak e wong liyo", indexNum: 98),
        PlayingCard(text: "Mukul wong tuwo ning tempat umum", indexNum: 99),
        PlayingCard(text: "Ngelempar kotoran ning omah e tonggo", indexNum: 100)
    ]
    @Published var gameState: GameState = GameState(){
        didSet{
            if isHost{
                //self.sendGameState(gameState)
            }
        }
    }
    
    init(username: String) {
        let peerID = MCPeerID(displayName: username)
        self.myPeerID = peerID
       
        //tambahin ini
        self.usernames = []
       
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .none)
        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceType)
        serviceBrowser = MCNearbyServiceBrowser(peer: peerID, serviceType: serviceType)
        
        super.init()
        
        //tambahin ini
        self.usernames = getNameFromDefaults()
        
        session.delegate = self
        serviceAdvertiser.delegate = self
        serviceBrowser.delegate = self
        
        serviceAdvertiser.startAdvertisingPeer()
    }
}

//MARK: - GAME FUNCTIONS
extension GameManager{ //Game Functions
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
    
    //tambahin ini
    func updateUsername(_ newUsername: String) {
//        self.usernames = newUsername
        self.usernames.append(newUsername)
    }
    
    // Fungsi untuk menyimpan nama pengguna ke UserDefaults
    func saveNameToDefaults(_ name: String) {
//        UserDefaults.standard.set(name, forKey: nameKey)
//        print("Username \(name) berhasil disimpan pada UserDefaults")
        var savedUsernames = getNameFromDefaults()  // Ambil nama-nama yang sudah ada
               savedUsernames.append(name)                      // Tambahkan username baru
               UserDefaults.standard.set(savedUsernames, forKey: nameKey)
               usernames = savedUsernames  // Update Published property agar UI ter-update
               print("Username \(name) berhasil disimpan pada UserDefaults")
    }
    
    // Fungsi untuk mengambil nama pengguna dari UserDefaults
    func getNameFromDefaults() -> [String] {
//        let savedName = UserDefaults.standard.string(forKey: nameKey) ?? ""
//        print("Username \(savedName) berhasil diambil dari UserDefaults")
//        return savedName
        let savedUsernames = UserDefaults.standard.stringArray(forKey: nameKey) ?? []
        usernames = savedUsernames  // Update Published property
        print("Usernames \(savedUsernames) berhasil diambil dari UserDefaults")
        return savedUsernames
    }
    
    // Fungsi untuk menghapus nama pengguna dari UserDefaults
    func clearSavedName() {
        UserDefaults.standard.removeObject(forKey: nameKey)
        usernames = [] // Setel username kosong
        print("Username berhasil dihapus dari UserDefaults")
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
        if gameState.players[gameState.guesser_PID].point >= 5{
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
    
    func save(name: String) {
        //        UserDefaults.standard.set(name, forKey: )
//        self.usernames = name
//        print("save username berhasil")
        self.usernames.append(name)
        
        // Simpan array usernames ke UserDefaults
        UserDefaults.standard.set(usernames, forKey: nameKey)
        print("save username berhasil")
    }
    
    func becomeHost(){
        myConnectivityType = .host
        myPID = 0
        gameState.players.append(Player(name: myPeerID.displayName))
        serviceBrowser.startBrowsingForPeers()
        serviceAdvertiser.stopAdvertisingPeer()
    }
    
    func sendGameState(_ gameState: GameState) {
        if !session.connectedPeers.isEmpty {
            log.info("send GameState to connected peers")
            do {
                let encoder = JSONEncoder()
                try session.send(encoder.encode(SendableGameData(type: .gameState, gameState: gameState, sender_PID: myPID)), toPeers: session.connectedPeers, with: .unreliable)
            } catch {
                log.error("Error sending: \(String(describing: error))")
            }
        }
    }
    
    func sendGameCommand(_ gameCommand: GameCommand){
        if !session.connectedPeers.isEmpty {
            log.info("send GameCommand to connected peers")
            do {
                let encoder = JSONEncoder()
                try session.send(encoder.encode(SendableGameData(type: .gameCommand, gameCommand: gameCommand, sender_PID: myPID)), toPeers: session.connectedPeers, with: .reliable)
            } catch {
                log.error("Error sending: \(String(describing: error))")
            }
        }
    }
    
    func sendGameCommand(_ gameCommand: GameCommand, to targetPeerID: MCPeerID){
        if !session.connectedPeers.isEmpty {
            log.info("send GameCommand to connected peers")
            do {
                let encoder = JSONEncoder()
                try session.send(encoder.encode(SendableGameData(type: .gameCommand, gameCommand: gameCommand, sender_PID: myPID)), toPeers: [targetPeerID], with: .reliable)
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
            DispatchQueue.main.async {
                //                self.paired = false
            }
            // Peer disconnected, start accepting invitations again
            if isHost {
                
            } else {
                log.info("Attempting to re-advertise as \(peerID.displayName)")
                self.stopAdvertisementRetry() // Cancel any existing retry timer before starting a new one
                self.startAdvertisementRetry() // Start a repeating timer to re-advertise every 4 seconds
            }
            break
            
        case MCSessionState.connected: //JUST CONNECTED <<<<<<<<<<<<<<<<<<<<<<<<<
            if isHost{
                if let PID = gameState.players.firstIndex(where: {$0.name == peerID.displayName}){
                    sendGameCommand(GameCommand(.assignPID, intData: PID), to: peerID)
                    sendGameState(gameState)
                }else{
                    DispatchQueue.main.async{ [self] in
                        sendGameCommand(GameCommand(.assignPID, intData: gameState.players.count), to: peerID)
                        gameState.players.append(Player(name: peerID.displayName))
                        sendGameState(gameState)
                    }
                }
            }else{
                DispatchQueue.main.async {
                    //                    self.paired = true
                    self.myConnectivityType = .guest
                }
                
                // We are paired, stop advertising and stop the retry timer
                serviceAdvertiser.stopAdvertisingPeer()
                self.stopAdvertisementRetry()
            }
            break
            
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
        let decoder = JSONDecoder()
        if let receivedGameData = try? decoder.decode(SendableGameData.self, from: data) {
            log.info("did receive SendableGameData from \(peerID.displayName)")
            DispatchQueue.main.async{ [self] in
                if isHost{
                    handleReceivedGameDataHost(receivedGameData, fromPeerID: peerID)
                }else if isGuest{
                    handleReceivedGameDataGuest(receivedGameData, fromPeerID: peerID)
                }
            }
        } else {
            log.info("did receive invalid value \(data.count) bytes")
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
                    myPID = newGameCommand.intData!
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
