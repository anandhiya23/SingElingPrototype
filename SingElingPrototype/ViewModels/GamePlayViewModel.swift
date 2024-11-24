//
//  GamePlayViewModels.swift
//  SingElingPrototype
//
//  Created by Haliza Syafa Oktaviani on 14/11/24.
//

import Foundation
import SwiftUI
import Combine

class GamePlayViewModel: ObservableObject {
    @State var vw: CGFloat = 0
    @State var vh: CGFloat = 0
    @State var announcementGame: Bool = false
    @Published var vmode: Int = 0
    
    @Published var isAnswer: Int = 0 {
        didSet {
            print("isAnswer updated: \(isAnswer)")
            if currentStage == .eleventhStage {
                print("Updating eleventh stage with isAnswer: \(isAnswer)")
            }
            print("isAnswer updated from \(oldValue) to \(isAnswer) in \(#function) at \(Date())")
        }
    }
    
    
    
    @State var announcementRole: Bool = false
    @State var guesserName: String = "Player1"
    @State var isCorrect: Bool = true
    @State var triggerGuesserCardShift: Bool = false
    @State var animationCompleted: Bool = false
    @State var myPID: Int = -1
    @State var buttonColor: Color = .blue
    
    @Published var isCardAnimated = false
    @Published var isCardTwoAnimated = false
    @Published var isBothCardsCentered = false
    @Published var areTwoCardsVisible = true
    @Published var isCardLandscape1 = false
    @Published var isCardLandscape2 = false
    @Published var isCardThreeAnimated = false
    @Published var isCardFourthAnimated = false
    @Published var isCardRightAnimated = false
    @Published var isCardLeftAnimated = false
    @Published var isFourCardAtTenthStageAnimated = false
    @Published var isFourCardAtEleventhStageAnimated = false
    @Published var isFourCardAtTenthStageDisappearing = false
    @Published var selectedCardIndex: Int = 0
    @Published var isTransitioning: Bool = false
    
    @Published var isFirstTextAnimated = false
    @Published var isFirstTextDisappearing = false
    @Published var isSecondTextShow = false
    @Published var isSecondTextDisappearing = false
    @Published var isThirdTextAnimated = false
    @Published var isThirdTextDisappearing = false
    @Published var isFourthTextAnimated = false
    @Published var isFourthTextDisappearing = false
    @Published var isFifthTextAnimated = false
    @Published var isFifthTextDisappearing = false
    @Published var isSixthTextAnimated = false
    @Published var isSixthTextDisappearing = false
    @Published var isSeventhTextAnimated = false
    @Published var isSeventhTextDisappearing = false
    @Published var isEighthTextAnimated = false
    @Published var isNinthTextAnimated = false
    @Published var isTenthTextAnimated = false
    @Published var isEleventhTextAnimated = false
    @Published var isTextNinthStageDisappearing = false
    @Published var isTwelfthTextAnimated = false
    @Published var isTwelfthTextDisappearing = false
    
    @Published var isArrowLineAnimated = false
    @Published var isArrowLineDisappearing = false
    @Published var isTextLeftArrowLine = false
    @Published var isTextRightArrowLine = false
    @Published var isDropZoneVisible = false
    @Published var isFirstDropZoneShow = false
    @Published var isSecondDropZoneShow = false
    @Published var isLeftThumbAnimated = false
    @Published var isRightThumbAnimated = false
    @Published var isLeftThumbDisappearing = false
    @Published var isRightThumbDisappearing = false
    @Published var isThumbLastAnimated = false
    
    @Published var isTelunjukAnimated = false
    @Published var isTelunjukDisappearing = false
    @Published var isTelunjukTapRightAnimated = false
    @Published var isTelunjukTapLeftAnimated = false
    @Published var isTelunjukTapDisappearing = false
    @Published var isTapped = false
    @Published var timer: Timer?
    
    @Published var isFirstCenterAnimated = false
    @Published var isSecondCenterAnimated = false
    @Published var isThirdAnimated = false
    
    @Published var currentButton: ButtonModel = ButtonModel(button: .lanjut)
    @Published var currentStatusButton: StatusButtonModel? = nil
    @Published var currentStage: Stage = .firstStage
    @Published var isNinthStageVisible = true
    @Published var isTenthStageFourCard = false
    
    @Published var part2IsVisible: Bool = false
    
    @Published var isButtonEnabled: Bool = false
    @Published var isSuccessOverlayVisible = true
    @Published var isFailedOverlayVisible = true
    @Published var isButtonClicked: Bool = false
    
    @Published var isDragging = false
    @Published var dragOffset: CGSize = .zero
    @Published var cardPositions: [CGFloat]
    
    // Default values
    private let defaultCardCount: Int = 4
    private let defaultSpacing: CGFloat = 120
    private var defaultInitialOffset: CGFloat {
        UIScreen.main.bounds.width / 2 - defaultSpacing
    }
    
    init() {
        let initialOffset = UIScreen.main.bounds.width / 2 - defaultSpacing
        let spacing = defaultSpacing
        let cardCount = defaultCardCount
        
        self.cardPositions = (0..<cardCount).map { index in
            initialOffset + CGFloat(index) * spacing
        }
        print("GamePlayViewModel initialized at \(Date())")
    }
    
    func updateCardPositions() {
        let initialOffset = UIScreen.main.bounds.width / 2 - defaultSpacing
        self.cardPositions = (0..<defaultCardCount).map { index in
            initialOffset + CGFloat(index - currentCardIndex) * defaultSpacing
        }
    }
    
    @State var currentCardOffset: CGFloat = 0
    @State var currentCardIndex: Int = 0
    
    enum Stage {
        case firstStage
        case secondStage
        case thirdStage
        case fourthStage
        case fifthStage
        case sixthStage
        case seventhStage
        case eighthStage
        case ninthStage
        case tenthStage
        case eleventhStage
    }
    
    @Published var myCards: [Int] = [24, 49, 30, 21]
    @Published var myCardPos = 0
    @State  var backgroundImageName: String = "Tiker Abu Terang"
    @State  var triggerMyCardShift: Bool = false
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    @State var penebakNewColor: Color = .white
    @State var pembacaNewColor: Color = .white
    
    @State  var guesserCards: [PlayingCard] = [
        PlayingCard(text: "Sample Card 1", indexNum: 1),
        PlayingCard(text: "Sample Card 2", indexNum: 2),
        PlayingCard(text: "Sample Card 3", indexNum: 3)
    ]
    
    @State  var guesserCardPos: Int = 1
    
    let cardImages = ["Card25-tutorial", "Card25-tutorial", "Card50-tutorial", "Card75-tutorial", "Card100-tutorial"]
    
    func startTimer() {
        print("Timer started")
    }
    
    
    var midCardY: CGFloat {
        switch vmode {
        case 0:
            return 55 / 100 * vh
        case 1:
            return 33 / 100 * vh
        default:
            return 70 / 100 * vh
        }
    }
    
    
    @State var hintTapped: Bool = false
    @State var penebakTapped: Bool = false
    @State var pembacaTapped: Bool = false
    
    let playerColor = CodableColor(color: .red)
    let penebakColor = CodableColor(color: .blue)
    let pembacaColor = CodableColor(color: .green)
    
    let backgroundImageMapping: [CodableColor: String] = [
        CodableColor(color: .singElingSB50): "Tikar Oren",
        CodableColor(color: .singElingLC50): "Tikar Merah",
        CodableColor(color: .singElingZ50): "Tikar Hijau",
        CodableColor(color: .singElingDSB50): "Tikar Biru",
    ]
    var penebakBackground: String {
        backgroundImageMapping[penebakColor] ?? "SingElingDarkGreen"
    }
    
    var pembacaBackground: String {
        backgroundImageMapping[pembacaColor] ?? "SingElingDarkGreen"
    }
    
    var playerBackground: String {
        backgroundImageMapping[playerColor] ?? "SingElingDarkGreen"
    }
    
    func getCardOffset(for index: Int) -> CGFloat {
        let spacing: CGFloat = 60
        let selectedSpacing: CGFloat = 80
        
        if index == selectedCardIndex {
            return 0
        } else if index < selectedCardIndex {
            return CGFloat(index - selectedCardIndex) * spacing - selectedSpacing
        } else {
            return CGFloat(index - selectedCardIndex) * spacing + selectedSpacing
        }
    }
    
    func buttonPressed() {
        print("is answer di button pressed \(isAnswer)")
        switch currentStage {
        case .firstStage:
            isButtonEnabled = false
            
            withAnimation(.easeIn(duration: 1.0)) {
                self.isFirstTextDisappearing = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation(.easeOut(duration: 1.0)) {
                    self.isSecondTextShow = true
                    self.isButtonEnabled = true
                    self.currentStage = .secondStage
                }
            }
            
        case .secondStage:
            isButtonEnabled = false
            
            withAnimation(.easeOut(duration: 1.0)) {
                self.isSecondTextShow = false
                self.isThirdTextAnimated = true
                self.isCardTwoAnimated = true
                self.isBothCardsCentered = true
                print("isCardTwoAnimated changed to true")
                self.isButtonEnabled = true
                self.currentStage = .thirdStage
            }
            
        case .thirdStage:
            isButtonEnabled = false
            
            withAnimation(.easeOut(duration: 1.0)){
                self.isThirdTextDisappearing = true
                self.isFourthTextAnimated = true
                self.isButtonEnabled = true
                self.currentStage = .fourthStage
            }
            
        case .fourthStage:
            isButtonEnabled = false
            
            withAnimation(.easeOut(duration: 1.0)) {
                self.isFourthTextDisappearing = true
                self.areTwoCardsVisible = false
                self.isCardLandscape1 = true
                self.isCardFourthAnimated = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation(.easeOut(duration: 1.0)) {
                    self.isFifthTextAnimated = true
                }
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.currentStage = .fifthStage
                    self.isButtonEnabled = true
                }
            }
            
        case .fifthStage:
            isButtonEnabled = false
            
            withAnimation(.easeIn(duration: 1.0)) {
                self.isFifthTextDisappearing = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                
                withAnimation(.easeOut(duration: 1.0)) {
                    self.isSixthTextAnimated = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.currentStage = .sixthStage
                self.isButtonEnabled = true
            }
            
        case .sixthStage:
            isButtonEnabled = false
            
            withAnimation(.easeIn(duration: 1.0)) {
                self.isSixthTextDisappearing = true
                self.isButtonEnabled = false
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation(.easeOut(duration: 1.0)) {
                    self.isArrowLineAnimated = true
                    self.isDropZoneVisible = true
                    self.isFirstDropZoneShow = true
                    self.isSecondDropZoneShow = false
                    self.isTextLeftArrowLine = true
                    self.isLeftThumbAnimated = true
                    self.isButtonEnabled = false
                }
                
   
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.easeIn(duration: 1.0)) {
                        self.isLeftThumbDisappearing = true
                        self.isButtonEnabled = false
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation(.easeOut(duration: 1.0)) {
                            self.isRightThumbAnimated = true
                            self.isDropZoneVisible = true
                            self.isFirstDropZoneShow = false
                            self.isTextLeftArrowLine = false
                            self.isSecondDropZoneShow = true
                            self.isTextRightArrowLine = true
                            self.isLeftThumbDisappearing = true
                            self.isButtonEnabled = false
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation(.easeOut(duration: 1.0)) {
                                self.isFirstCenterAnimated = true
                                self.isButtonEnabled = false
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            withAnimation(.easeOut(duration: 1.0)) {
                                self.isFirstCenterAnimated = false
                                self.isSecondCenterAnimated = true
                                self.isTextLeftArrowLine = true
                                self.isTextRightArrowLine = false
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                            withAnimation(.easeOut(duration: 1.0)) {
                                self.isSecondCenterAnimated = true
                                self.isArrowLineDisappearing = true
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                            withAnimation(.easeOut(duration: 1.0)) {
                                self.isSeventhTextAnimated = true
                                self.isButtonEnabled = true
                                self.currentStage = .seventhStage
                            }
                        }
                    }
                }
            }
            
        case .seventhStage:
            isButtonEnabled = false
            self.currentButton = ButtonModel(button: .kunci)
            
            withAnimation(.easeIn(duration: 1.0)) {
                self.isSeventhTextDisappearing = true
                self.isThirdAnimated = true
                self.isSecondCenterAnimated = true
                self.isTelunjukTapRightAnimated = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.easeIn(duration: 1.0)) {
                    self.isTelunjukTapLeftAnimated = true
                    self.isCardLeftAnimated = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                withAnimation(.easeIn(duration: 1.0)) {
                    self.isTelunjukTapRightAnimated = true
                    self.isTelunjukTapLeftAnimated = false
                    self.isCardLeftAnimated = false
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                withAnimation(.easeIn(duration: 1.0)) {
                    self.isTelunjukTapLeftAnimated = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
                withAnimation(.easeIn(duration: 1.0)) {
                    self.isTelunjukTapRightAnimated = true
                    self.isTelunjukTapLeftAnimated = false
                    self.isCardRightAnimated = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                self.currentStage = .eighthStage
                self.isTelunjukTapRightAnimated = false
                self.isButtonEnabled = true
            }
            
        case .eighthStage:
            isButtonEnabled = false
            self.isTelunjukTapRightAnimated = false
            self.currentStatusButton = StatusButtonModel(statusButton: .taruh)
            
            withAnimation(.easeIn(duration: 1.0)) {
                self.isButtonEnabled = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.easeIn(duration: 1.0)) {
                        if self.isCardRightAnimated {
                            if self.currentStage == .eighthStage {
                                self.vmode = 2
                            }
                        } else {
                            if self.currentStage == .eighthStage {
                                self.vmode = 1
                            }
                        }
                    }
                }
            }
            
        case .ninthStage:
            self.currentButton = ButtonModel(button: .lanjut)
            isButtonEnabled = false
            
            withAnimation(.easeIn(duration: 1.0)) {
                self.isEighthTextAnimated = true
                self.isNinthTextAnimated = true
                self.isTenthTextAnimated = true
                self.isEleventhTextAnimated = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.isTextNinthStageDisappearing = true
                self.isButtonEnabled = true
                self.currentStage = .tenthStage
            }
            
        case .tenthStage:
            self.isTransitioning = true
            withAnimation(.easeIn(duration: 1.0)) {
                self.isTwelfthTextAnimated = true
                self.isFourCardAtTenthStageAnimated = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.isButtonEnabled = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.isTwelfthTextDisappearing = true
                    self.isFourCardAtTenthStageDisappearing = true
                    self.isFourCardAtEleventhStageAnimated = true
                    self.currentButton = ButtonModel(button: .kunci)
                    self.isButtonEnabled = true
                    self.currentStage = .eleventhStage
                    print("akhir tenth stage")
                }
            }
            
            
        case .eleventhStage:
            print("awal eleventh stage")
            isButtonEnabled = true
            self.currentStage = .eleventhStage
            self.currentStatusButton = StatusButtonModel(statusButton: .taruh)
            print("isAnswer di eleventhstage: \(self.isAnswer)")
            self.isDragging = true
            
            withAnimation(.easeIn(duration: 1.0)) {
                self.isThumbLastAnimated = true
                self.isCardLandscape2 = true
            }
            
            print("mau panggil isButtonClicked")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                print("Setting button clicked after transition")
                
                print("Before setting isButtonClicked: isAnswer = \(self.isAnswer)")
                self.isButtonClicked = true
                if self.isAnswer == 0 || self.isAnswer == 1{
                    self.vmode = 1
                    self.isFailedOverlayVisible = true
                } else{
                    self.vmode = 2
                    self.isSuccessOverlayVisible = true
                }
                print("After setting isButtonClicked: isAnswer = \(self.isAnswer)")
                
                print("isAnswer di dispatchque eleventhstage: \(self.isAnswer)")
            }
            
            
        }
    }
    
    
    func enableButton() {
        isButtonEnabled = true
    }
    
    func startTelunjukAnimation(){
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            withAnimation {
                self.isTapped.toggle()
            }
        }
    }
    
    func stopTelunjukAnimation() {
        timer?.invalidate()
        timer = nil
    }
    
    func nextStage() {
        print("Before updating stage: \(currentStage)")
        switch currentStage {
        case .eighthStage:
            currentStage = .ninthStage
            isSuccessOverlayVisible = false // Hilangkan overlay
            isNinthStageVisible = false
            self.currentStatusButton = nil
            self.vmode = 0
            self.isButtonEnabled = false
            print("Moving to ninthStage")
        case .ninthStage:
            self.vmode = 0
            currentStage = .tenthStage
        case .tenthStage:
            currentStage = .eleventhStage
        case .eleventhStage:
            isSuccessOverlayVisible = false
            print("Moving to tutorial view")
        default:
            print("nextStage conditions not met. Current Stage: \(currentStage)")
        }
        print("After updating stage: \(currentStage)")
    }
    
    func backStage() {
        withAnimation(.easeIn(duration: 1.0)) {
            // Reset ke eighthStage
            switch currentStage {
            case .eighthStage:
                currentStage = .eighthStage
                self.vmode = 0
            case .eleventhStage:
                currentStage = .tenthStage
                isFailedOverlayVisible = false
                self.vmode = 0
            default:
                isFailedOverlayVisible = false
                self.vmode = 0 // Reset vmode
                self.currentStatusButton = nil
                self.isButtonEnabled = true
            }
        }
    }
    
}
