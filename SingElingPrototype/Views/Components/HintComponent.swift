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
    
    var body: some View {
        HStack {
            Image(hintModel.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: width * (30 / 300), height: width * (30 / 300))

            HighlightedTextView(
                fullText: hintModel.text,
                highlightedText: hintModel.readerName ?? "",
                highlightedColor: .singGreen
            )
            .multilineTextAlignment(.center)
            .font(.custom("Skrapbook", size: width * (20 / 300)))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: width * (20 / 300))
                .fill(Color.backgroundCream)
        )
        .padding(.horizontal)
    }
}

struct HighlightedTextView: View {
    let fullText: String
    let highlightedText: String
    let highlightedColor: Color

    var body: some View {
        if fullText.contains(highlightedText) {
            let parts = fullText.components(separatedBy: highlightedText)
            
            Text(parts[0]) +
            Text(highlightedText)
                .foregroundColor(highlightedColor) +
            Text(parts[1])
        } else {
            Text(fullText)
        }
    }
}


#Preview {
    HintComponent(hintModel: HintModel(userRole: .bystanderView, readerName: ""), width: 300)
}
