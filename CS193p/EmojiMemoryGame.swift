//
//  EmojiMemoeyGame.swift
//  CS193p
//  ViewModel
//  Created by 王崇锦 on 07/01/2025.
//
import SwiftUI

class EmojiMemoryGame: ObservableObject{
    private static let emojis = ["🥲","🥸","🤩","🥶","🙂","🥲","🥸","🤩","🥶","🙂","🥲","🥸","🤩","🥶","🙂","🥲","🥸","🤩","🥶","🙂"]
    //闭包，MemoryGame有一个参数是func
    private static func createMemoeyGame()->MemoryGame<String>{
        return MemoryGame(numberOfPairsOfCards: 6){ //pairIndex in
            if emojis.indices.contains($0){
                return EmojiMemoryGame.emojis[$0]
            } else {
                return "?? out of index"
            }
        }
    }
    
    @Published private var model = createMemoeyGame()
    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    // MARK: - Intents
    func shuffle(){
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
    
}
