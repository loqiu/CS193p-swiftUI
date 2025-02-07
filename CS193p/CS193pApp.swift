//
//  CS193pApp.swift
//  CS193p
//
//  Created by 王崇锦 on 04/01/2025.
//

import SwiftUI

@main
struct CS193pApp: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
