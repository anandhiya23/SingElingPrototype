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
    @Published var myPID: Int = -1
    @Published var myConnectivityStatus = 0
    @Published var myConnectivityType: ConnectivityType = .unknown
    @Published var curView: Int? = nil
    @Published var hostRoomCode: [Int] = []
    @Published var guestRoomCode: [Int] = []
    
    //tambahin ini
    private let nameKey = "name"
    
    //    @Published var usernames: [String] = []
    @Published var isCodeValidated = false
    @Published var isPlaying: Bool = false
    
    var inputIdentifiers: [Int] = []
    
    @Published var winnerColor: Color = .black
    
    //background image berdasarkan user
    let backgroundImages = ["Tikar Biru", "Tikar Hijau", "Tikar Merah", "Tikar Oren"]
    
//    let playerColors = [CodableColor(color: .orange), CodableColor(color: .blue), CodableColor(color: .green), CodableColor(color: .pink)]
    
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
        PlayingCard(text: "mangan jajan e konco tapi ora cuci tangan", indexNum: 1),
        PlayingCard(text: "lali nggowo barang e konco pas arep mbalikno", indexNum: 2),
        PlayingCard(text: "ora mbales chat e konco", indexNum: 3),
        PlayingCard(text: "ora sengojo nyenggol konco sing lagi ngombe", indexNum: 4),
        PlayingCard(text: "gak nyopo konco pas papasan", indexNum: 5),
        PlayingCard(text: "ngguyu ndelok konco sing lagi kepleset", indexNum: 6),
        PlayingCard(text: "nyilih jaket e konco, tapi gak sengojo ketumpahan banyu", indexNum: 7),
        PlayingCard(text: "nyingit no hp e konco", indexNum: 8),
        PlayingCard(text: "Pacaran ning ngarepe wong jomblo", indexNum: 9),
        PlayingCard(text: "usil narik tali sepatu e konco", indexNum: 10),
        PlayingCard(text: "mangan ning ngarepe wong sing lagi puasa", indexNum: 11),
        PlayingCard(text: "sikile munggah kursi pas mangan ning omahe konco", indexNum: 12),
        PlayingCard(text: "nyilih barang wek e konco tapi ora ijin", indexNum: 13),
        PlayingCard(text: "julid i unggahan instagram e konco", indexNum: 14),
        PlayingCard(text: "mangan jajan e konco tanpa ijin", indexNum: 15),
        PlayingCard(text: "ngusili wong liyo pas sek mangan", indexNum: 16),
        PlayingCard(text: "nyeluk uwong sambil mukul pundak e", indexNum: 17),
        PlayingCard(text: "mangan karo ngecap banter", indexNum: 18),
        PlayingCard(text: "mencet remot tv nggawe sikil ning ngarepe konco", indexNum: 19),
        PlayingCard(text: "takon “kapan rabi” nang konco sing jomblo", indexNum: 20),
        PlayingCard(text: "ngidek sepatu anyar e konco", indexNum: 21),
        PlayingCard(text: "ngongkon konco tanpa ngomong “tulung”", indexNum: 22),
        PlayingCard(text: "numplekno toples kong guan isi rengginang ning omah e konco", indexNum: 23),
        PlayingCard(text: "komen julid ning sosmed e wong liyo", indexNum: 24),
        PlayingCard(text: "mangan karo ngomong sampe muncrat", indexNum: 25),
        PlayingCard(text: "Ngomong nggremeng nang abang ojek", indexNum: 26),
        PlayingCard(text: "numplekno kopi ning klambi ne konco", indexNum: 27),
        PlayingCard(text: "sengojo ngentut ning tempat umum", indexNum: 28),
        PlayingCard(text: "ngentut buanter pas rapat", indexNum: 29),
        PlayingCard(text: "ora ngucapno salam pas namu ning omahe wong liyo", indexNum: 30),
        PlayingCard(text: "ora ngumbah sikil sak durunge munggah kasur e konco", indexNum: 31),
        PlayingCard(text: "nyolong bulpen e konco", indexNum: 32),
        PlayingCard(text: "nyenggol tangane lawan jenis sing mari wudhu", indexNum: 33),
        PlayingCard(text: "nggibah ning bioskop", indexNum: 34),
        PlayingCard(text: "nirukno suara e wong liyo berkali kali", indexNum: 35),
        PlayingCard(text: "nyilih klambi e konco tapi ora dibalikno", indexNum: 36),
        PlayingCard(text: "jajan gawe duwik kembalian belonjoan teko wong tuwo", indexNum: 37),
        PlayingCard(text: "mondar mandir waktu mbak mu lagi nyapu", indexNum: 38),
        PlayingCard(text: "nyeluk konco gawe jeneng e wong tuwo e", indexNum: 39),
        PlayingCard(text: "glegeken banter ning ngarepe wong akeh", indexNum: 40),
        PlayingCard(text: "sengojo nyerobot antrian ning tempat umum", indexNum: 41),
        PlayingCard(text: "melotot nang wong sing gak dikenal", indexNum: 42),
        PlayingCard(text: "nyombongno gaji pas pendekatan", indexNum: 43),
        PlayingCard(text: "nganggo nada tinggi pas ngomong karo konco", indexNum: 44),
        PlayingCard(text: "teko ning nikahan e wong sing gadikenal", indexNum: 45),
        PlayingCard(text: "ngirim meme tanpa konteks nang grub keluarga sing lagi serius", indexNum: 46),
        PlayingCard(text: "nyetel musik sampe tonggone budeg jam 2 isuk", indexNum: 47),
        PlayingCard(text: "nyilih duwik 100 rb tapi ora dibalikno", indexNum: 48),
        PlayingCard(text: "split bill tapi ora dibayar", indexNum: 49),
        PlayingCard(text: "ngomong “ck’ pas dikongkon wong tuwo", indexNum: 50),
        PlayingCard(text: "takon hal sing sensitif pas kencan pertama", indexNum: 51),
        PlayingCard(text: "Mbukak paket konco sak penak e dewe", indexNum: 52),
        PlayingCard(text: "buka whatsapp e konco tanpa ijin", indexNum: 53),
        PlayingCard(text: "buka galeri hp e konco tanpa ijin", indexNum: 54),
        PlayingCard(text: "ora njaluk sepuro pas nabrak wong liyo", indexNum: 55),
        PlayingCard(text: "nggawe klambi seksi pas meeting ning kantor", indexNum: 56),
        PlayingCard(text: "ngenyek konco sing lagi sinau bahasa inggris", indexNum: 57),
        PlayingCard(text: "ngacungno jari tengah moro moro nang wong random", indexNum: 58),
        PlayingCard(text: "turu pas dosen lagi jelasno materi", indexNum: 59),
        PlayingCard(text: "ngenyek konco sing lagi sedih", indexNum: 60),
        PlayingCard(text: "masak mi instan padahal ibuk wes masak", indexNum: 61),
        PlayingCard(text: "ora ngomong matur suwun sak wis e dibantu", indexNum: 62),
        PlayingCard(text: "njiplak tugas e konco", indexNum: 63),
        PlayingCard(text: "ngeklaim kerjoan e wong liyo", indexNum: 64),
        PlayingCard(text: "njupuk gorengan loro tapi mek dibayar siji", indexNum: 65),
        PlayingCard(text: "nyilih motor e konco sampe bensin e entek", indexNum: 66),
        PlayingCard(text: "njaluk tebengan karo pacar e konco", indexNum: 67),
        PlayingCard(text: "nuker sepatu sing apik pas solat jumat", indexNum: 68),
        PlayingCard(text: "Nyabut taneman e tonggo", indexNum: 69),
        PlayingCard(text: "nyalahno konco ning ngarepe wong akeh", indexNum: 70),
        PlayingCard(text: "nyilih barang tanpa ijin terus rusak", indexNum: 71),
        PlayingCard(text: "telfonan romantis karo mbok e konco", indexNum: 72),
        PlayingCard(text: "Selingkuh karo pacare konco", indexNum: 73),
        PlayingCard(text: "Njaluk duit wong tuwo gawe dugem, padahal alesane gawe bayar SPP", indexNum: 74),
        PlayingCard(text: "ngerokok sambil motoran terus kenek mripat e wong liyo", indexNum: 75),
        PlayingCard(text: "moro-moro dolan ning omahe dosen bengi-bengi", indexNum: 76),
        PlayingCard(text: "nelfon guru jam 2 isuk", indexNum: 77),
        PlayingCard(text: "dulinan hp pas wong tuwo lagi ceramah", indexNum: 78),
        PlayingCard(text: "nggudo arek wedok bengi bengi ing dalan", indexNum: 79),
        PlayingCard(text: "Ngrumpi pas pengajian", indexNum: 80),
        PlayingCard(text: "nyebarno berita hoax tentang guru nang arek sak angkatan", indexNum: 81),
        PlayingCard(text: "ganggu ibadah e wong liyo", indexNum: 82),
        PlayingCard(text: "motong pembicaraan e wong tuwo", indexNum: 83),
        PlayingCard(text: "ngidu ning pinggir dalan terus ngenek i wong liyo", indexNum: 84),
        PlayingCard(text: "nyawat mercon ning omah e tonggo", indexNum: 85),
        PlayingCard(text: "ngelempar kotoran ning omah e tonggo", indexNum: 86),
        PlayingCard(text: "ngenyek fisik e wong tuwo ning tempat umum", indexNum: 87),
        PlayingCard(text: "ngerebut hak e wong liyo", indexNum: 88),
        PlayingCard(text: "ngguyu ning pemakaman e wong liyo", indexNum: 89),
        PlayingCard(text: "nyeluk wong tuwo gawe jeneng e", indexNum: 90),
        PlayingCard(text: "misuh nang dosen pas bimbingan skirpsi", indexNum: 91),
        PlayingCard(text: "misuh ning wong tuwo", indexNum: 92),
        PlayingCard(text: "mbentak karo wong tuwo", indexNum: 93),
        PlayingCard(text: "Nyuri duwik sumbangan", indexNum: 94),
        PlayingCard(text: "ngeplak ndas e konco", indexNum: 95),
        PlayingCard(text: "ngejek guru ning ngarep e kelas", indexNum: 96),
        PlayingCard(text: "munggahno sikil ning ngarepe wong tuwo", indexNum: 97),
        PlayingCard(text: "ndeleh sikil ning ndas e wong tuwo", indexNum: 98),
        PlayingCard(text: "mukul wong tuwo ning tempat umum", indexNum: 99),
        PlayingCard(text: "nyeleding sikil e guru sampe ceblok", indexNum: 100)
    ]
    
    @Published var gameState: GameState = GameState(){
        didSet{
            if isHost{
                //self.sendGameState(gameState)
            }
        }
    }
    
    let backgroundCards = ["Card1", "Card2", "Card3", "Card4",  "Card5", "Card6", "Card7", "Card8", "Card9", "Card10", "Card11", "Card12", "Card13", "Card14", "Card15", "Card16", "Card17", "Card18", "Card19", "Card20", "Card21", "Card22", "Card23", "Card24", "Card25", "Card26", "Card27", "Card28", "Card29", "Card30", "Card31", "Card32", "Card33", "Card34", "Card35", "Card36", "Card37", "Card38", "Card39", "Card40", "Card41", "Card42", "Card43", "Card44", "Card45", "Card46", "Card47", "Card48", "Card49", "Card50", "Card51", "Card52", "Card53", "Card54", "Card55", "Card56", "Card57", "Card58", "Card59", "Card60", "Card61", "Card62", "Card63", "Card64", "Card65", "Card66", "Card67", "Card68", "Card69", "Card70", "Card71", "Card72", "Card73", "Card74", "Card75", "Card76", "Card77", "Card78", "Card79", "Card80", "Card81", "Card82", "Card89", "Card90", "Card91", "Card92", "Card93", "Card94", "Card95", "Card96", "Card97", "Card98", "Card99", "Card100"]
    
    func getBackground(for index: Int) -> String {
        backgroundCards[index % backgroundCards.count]
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
    
    // Fungsi untuk mendapatkan gambar background dari warna pemain
    func getBackgroundImage(for color: CodableColor) -> String {
        return backgroundImageMapping[color] ?? "SingElingDarkGreen" 
    }
    
    public func initGuest(myUsername: String, discoveryInfo: [String: String]? = nil) {
        myPeerID = MCPeerID(displayName: myUsername)
        session = MCSession(peer: myPeerID, securityIdentity: nil, encryptionPreference: .none)
        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: discoveryInfo, serviceType: serviceType)
        
        session.delegate = self
        serviceAdvertiser.delegate = self
        
        self.serviceAdvertiser.startAdvertisingPeer()
    }
    
    public func initHost(myUsername: String){
        myPeerID = MCPeerID(displayName: myUsername)
        session = MCSession(peer: myPeerID, securityIdentity: nil, encryptionPreference: .none)
        serviceBrowser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: serviceType)
        
        session.delegate = self
        serviceBrowser.delegate = self
        
        myConnectivityType = .host
        myPID = 0
        
//        let backgroundImage = backgroundImages[Int.random(in: 0..<backgroundImages.count)]
        let color = playerColors[Int.random(in: 0..<playerColors.count)]
        
        // Tambahkan pemain host dengan gambar latar belakang dan warna yang dipilih
        let hostPlayer = Player(name: myPeerID.displayName, color: color)
        gameState.players.append(hostPlayer)
        
        serviceBrowser.startBrowsingForPeers()
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
        
        gameState.roomIdentifiers = identifiers
        gameState.roomImages = iconNames

        print("Generated room code identifiers: \(identifiers)")
        print("Generated room images: \(iconNames)")
        
        print("Sending room identifiers to guest: \(gameState.roomIdentifiers)")
        sendGameState(gameState)
    }
    
    func setGuestInputIdentifiers(_ identifiers: [Int]) {
        self.inputIdentifiers = identifiers
    }
    
//    func getIdentifier(for imageName: String?) -> Int? {
//        guard let imageName = imageName else { return nil }
//        if let index = gameState.roomImages.firstIndex(of: imageName) {
//            // Ensure the index is valid for identifiers array
//            if index < gameState.roomIdentifiers.count {
//                return gameState.roomIdentifiers[index]
//            } else {
//                print("Index out of range for identifiers array")
//                return nil
//            }
//        }
//        print("Image name not found: \(imageName)")
//        return nil
//    }
//    func getIdentifier(for iconID: Int?) -> Int? {
//        guard let iconID = iconID else { return nil }
//        
//        // Cek apakah iconID ada dalam daftar roomIdentifiers
//        if gameState.roomIdentifiers.contains(iconID) {
//            return iconID // Jika iconID ditemukan, kembalikan iconID tersebut
//        }
//        
//        // Jika tidak ditemukan, log error
//        print("IconID not found: \(iconID)")
//        return nil
//    }

    func getIdentifier(for iconID: Int) -> Int? {
        // Pastikan iconID ditemukan dalam roomIdentifiers dan kembalikan identifier yang benar
        if let index = gameState.roomIdentifiers.firstIndex(of: iconID) {
            return gameState.roomIdentifiers[index]
        } else {
            print("IconID not found: \(iconID)") // Debugging
            return nil
        }
    }

    
    //    func validateGuestCode(inputColors: [Color], inputImages: [String]) -> Bool {
    func validateGuestCode() -> Bool {
        //         guard inputColors.count == 4 && inputImages.count == 4 else {
        //             print("Error: panjang array input tidak valid.")
        //             return false
        //         }
        //
        ////         // Konversi CodableColor ke Color untuk validasi
        ////         let generatedColors = gameState.roomColors.map { $0.toColor() }
        ////
        ////         // Bandingkan input dari guest dengan kode room yang sudah dihasilkan oleh host
        ////         if inputColors == generatedColors && inputImages == gameState.roomImages {
        ////             print("Kode room guest valid!")
        ////             return true
        ////         } else {
        ////             print("Kode room guest tidak valid.")
        ////             return false
        ////         }
        //        // Dapatkan warna dan gambar yang telah dihasilkan oleh host dari gameState
        //        let generatedColors = gameState.roomColors.map { $0.toColor() }
        //        let generatedImages = gameState.roomImages
        //
        //        // Debug: Tampilkan warna dan gambar yang dihasilkan oleh host
        //        print("Generated colors for validation:", generatedColors)
        //        print("Generated images for validation:", generatedImages)
        //        print("Input colors:", inputColors)
        //        print("Input images:", inputImages)
        //
        //        // Validasi kode room berdasarkan input guest dengan data host
        //        let colorsMatch = inputColors == generatedColors
        //        let imagesMatch = inputImages == generatedImages
        //
        //        if colorsMatch && imagesMatch {
        //            print("Kode room guest valid!")
        //            return true
        //        } else {
        //            print("Kode room guest tidak valid.")
        //            return false
        //        }
        // Warna dan gambar yang di-set secara manual untuk sementara
//        let testInputColors: [Color] = [.singElingLC10, .singElingLC50, .singElingZ50, .singElingPG50]
//        let testInputImages: [String] = ["tree", "flower", "mask", "sword"]
//        
//        // Konversi `roomColors` dari `gameState` agar sesuai dengan format warna untuk perbandingan
//        let generatedColors = gameState.roomColors.map { $0.toColor() }
//        print("Generated colors for validation: \(generatedColors)")
//        print("Generated images for validation: \(gameState.roomImages)")
//        print("Test Input colors: \(testInputColors)")
//        print("Test Input images: \(testInputImages)")
//        
//        // Bandingkan `testInputColors` dan `testInputImages` langsung
//        print("ROOM IMAGES: \(gameState.roomImages)")
//        print("ROOM COLORS: \(gameState.roomColors)")
//        if testInputImages == gameState.roomImages {
//            print("Kode room guest valid!")
//            return true
//        } else {
//            print("Kode room guest tidak valid.")
//            return false
//        }
        guard isHost else {
            print("Only the host can validate the room code.")
            return false
        }
        
        // Compare guest input identifiers to the stored room code identifiers
        if inputIdentifiers == gameState.roomIdentifiers {
            print("Guest room code is valid!")
            return true
        } else {
            print("Guest room code is invalid.")
            return false
        }
    }
    
//    func receiveGameState() {
//         // Menunggu data gameState dari host (misalnya menggunakan notification atau delegasi)
//         // Di sini, Anda bisa mengupdate gameState dan roomIdentifiers pada guest
//         gameManager.gameState = receivedGameState
//     }
    
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
            print(PID)
            print(gameState.players[PID].name)
            print(gameState.players[PID].playingCards_CID)
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
    
//    func save(name: String) {
//        //        UserDefaults.standard.set(name, forKey: )
//        //        self.usernames = name
//        //        print("save username berhasil")
//        //        self.usernames.append(name)
//        self.username = name
//        
//        // Simpan array usernames ke UserDefaults
//        //        UserDefaults.standard.set(usernames, forKey: nameKey)
//        print("save username berhasil")
//    }
    func sendGameState(_ gameState: GameState) {
//        if !session.connectedPeers.isEmpty {
//            log.info("send GameState to connected peers")
//            do {
//                let encoder = JSONEncoder()
//                try session.send(encoder.encode(SendableGameData(type: .gameState, gameState: gameState, sender_PID: myPID)), toPeers: session.connectedPeers, with: .reliable) //ini tadinya unreliable
//            } catch {
//                log.error("Error sending: \(String(describing: error))")
//            }
//        }
        // Pastikan ada peers yang terhubung
        if !session.connectedPeers.isEmpty {
            log.info("Sending GameState to connected peers.")
            
            do {
                // Membuat objek SendableGameData dengan gameState yang ingin dikirim
                let sendableData = SendableGameData(type: .gameState, gameState: gameState, sender_PID: myPID)
                
                // Encode objek menjadi Data untuk dikirimkan
                let encoder = JSONEncoder()
                let encodedData = try encoder.encode(sendableData)
                
                print("Host is sending gameState with room identifiers: \(gameState.roomIdentifiers)")
                
                // Kirimkan data yang telah diencode ke peers yang terhubung
                try session.send(encodedData, toPeers: session.connectedPeers, with: .reliable)
                log.info("GameState successfully sent to \(self.session.connectedPeers.count) peers.")
                
            } catch {
                // Tangani error jika pengiriman gagal
                log.error("Failed to send GameState: \(error.localizedDescription)")
            }
        } else {
            log.warning("No peers connected. Unable to send GameState.")
        }
    }
    
    //tambahin disini
    
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
//        self.receiveGameState()
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
                        let backgroundImage = backgroundImages[Int.random(in: 0..<backgroundImages.count)]
                        let color = playerColors[Int.random(in: 0..<playerColors.count)]
                              
                        gameState.players.append(Player(name: peerID.displayName, color: color))
                        

                        sendGameCommand(GameCommand(.assignPID, intData: gameState.players.count - 1), to: peerID)

//                        gameState.players.append(Player(name: peerID.displayName, backgroundImage: backgroundImages[Int.random(in: 0..<backgroundImages.count)]))
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
//            break
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
