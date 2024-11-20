//
//  SingElingPrototypeApp.swift
//  SingElingPrototype
//
//  Created by Bintang Anandhiya on 16/10/24.
//

import SwiftUI

@main
struct SingElingPrototypeApp: App {
    @StateObject private var gameManager = GameManager()
    var body: some Scene {
        WindowGroup {
//            MainView()
//                .environmentObject(gameManager)
            GamePlayTutorial()
        }
    }
}
