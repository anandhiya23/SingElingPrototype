//
//  test.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 07/11/24.
//

import SwiftUI

struct test: View {
    @State private var selectedCardIndex: Int = 0 // State harus di luar body
    @EnvironmentObject var gamePlayViewModel: GamePlayViewModel
    @State var vw: CGFloat = 0
    @State var vh: CGFloat = 0
    @State var myCardPos = 0

    var body: some View {
        GeometryReader { geom in
            
            let myCards: [Int] = [24, 49, 74, 99]
            let playingCards: [PlayingCard] = [ //tambahin @Published
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
           
            ZStack {
                HStack(spacing: 30) {
                    ForEach(0..<myCards.count, id: \.self) { curCardIdIndice in
                        let curCardId = myCards[curCardIdIndice]
                        let tempCard: PlayingCard = playingCards[curCardId]
                        
                        // Atur padding untuk membuat gap antara kartu terpilih dan kartu setelahnya
                        CardComponent(width: 120, text: tempCard.text, indexNum: tempCard.indexNum, backgroundImage: "Card\(tempCard.indexNum)")
                            .padding(.leading, curCardIdIndice == myCardPos ? 20 : (curCardIdIndice == myCardPos + 1 ? 70 : -60))
                    }
                }
                .padding(.leading, (vw / 2) - CGFloat(myCardPos * 85))
                .frame(width: vw, alignment: .leading)
                .animation(.bouncy.speed(1.4), value: myCardPos)
               
                .gesture(
                    DragGesture()
                        .onEnded { gesture in
                            if gesture.translation.width > 50 {
                                
                                myCardPos -= 1
                                print("kiri\(myCardPos)")
                            } else if gesture.translation.width < -50 {
                                myCardPos += 1
                                print("kanan\(myCardPos)")
                            }
                            let currentCardIndex = myCards[myCardPos]
                                                        gamePlayViewModel.isAnswer = (currentCardIndex == 49) ? 2 : 1
                       

                            if gamePlayViewModel.isAnswer == 2 {
                                       // Jika jawaban benar, tampilkan SuccessOverlay
                                       SuccessOverlayView {
                                           print("di test.swiftUI: Jawaban benar, lanjut ke stage berikutnya")
                                           gamePlayViewModel.nextStage()
                                       }
                                   } else {
                                       // Jika jawaban salah, tampilkan FailedOverlay
                                       FailedOverlayView {
                                           print("di test.swiftUI: Jawaban salah, kembali ke stage sebelumnya")
                                           gamePlayViewModel.backStage()
                                       }
                                   }
                            
                        }
                )
            }
            .position(y: vh * 0.7)
            .onChange(of: geom.size) { oldValue, newValue in
                vw = newValue.width
                vh = newValue.height
            }
            .onAppear{
                vw = geom.size.width
                vh = geom.size.height
            }
            .onReceive(gamePlayViewModel.$isAnswer) { newValue in
                print("Observed isAnswer: \(newValue)")
                if gamePlayViewModel.currentStage == .eleventhStage {
                    print("Updating UI with new isAnswer: \(newValue)")
                }
            }
        }
    }
    func getCardOffset(for index: Int) -> CGFloat {
        let spacing: CGFloat = 10

        if index == selectedCardIndex {
            return 0
        } else if index < selectedCardIndex {
            return CGFloat(index - selectedCardIndex) * spacing - 100
        } else {
            return CGFloat(index - selectedCardIndex) * spacing + 100
        }
    }

}



#Preview {
    test()
        .environmentObject(GamePlayViewModel())
}
