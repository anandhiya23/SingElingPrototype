//
//  HintView.swift
//  SingElingPrototype
//
//  Created by Bintang Anandhiya on 24/10/24.
//

import SwiftUI

struct HintComponent: View {
    var hintModel: HintModel
    var width: CGFloat
    var highlightedColor: Color?

    
    var body: some View {
        HStack {
            if let imageName = hintModel.imageName{

                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: width * (30 / 300), height: width * (30 / 300))
            }

            HighlightedTextView(
                fullText: hintModel.text,
                highlightedText: "Anda",
                highlightedColor: highlightedColor
            )
            .multilineTextAlignment(.center)
            .font(.custom("Skrapbook", size: width * (20 / 300)))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: width * (20 / 300))
                .fill(Color.singElingLC10)
        )
        .padding(.horizontal)
    }
}

struct HighlightedTextView: View {
    let fullText: String
    let highlightedText: String
    let highlightedColor: Color?

    var body: some View {
        if fullText.contains(highlightedText) {
            let parts = fullText.components(separatedBy: highlightedText)
            
            HStack(spacing: 0) {
                Text(parts[0])
                if let color = highlightedColor {
                    Text(highlightedText)
                        .foregroundColor(color)
                } else {
                    Text(highlightedText)
                }
                if parts.count > 1 {
                    Text(parts[1])
                }
            }
        } else {
            Text(fullText)
        }
    }
}


//#Preview {
//    let gameManager = GameManager(username: "Haliza")
//    
//    HintComponent(
//        hintModel: HintModel(userRole: .penebakView, readerName: "Haliza"),
//        width: 300,
//        highlightedColor: gameManager.currentUserColor
//    )
//    .environmentObject(gameManager)
//}

