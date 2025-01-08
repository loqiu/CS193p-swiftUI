//
//  EmojiMemoeyGame.swift
//  CS193p
//  ViewModel
//  Created by 王崇锦 on 07/01/2025.
//
import SwiftUI

class EmojiMemoryGame: ObservableObject{
    private static let emojis = ["🥲","🥸","🤩","🥶","🙂","🥲","🥸","🤩","🥶","🙂","🥲","🥸","🤩","🥶","🙂","🥲","🥸","🤩","🥶","🙂","🥲","🥸","🤩","🥶","🙂","🥲","🥸","🤩","🥶","🙂","🥲","🥸","🤩","🥶","🙂","🥲","🥸","🤩","🥶","🙂"]
    //闭包，MemoryGame有一个参数是func
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 18){ //pairIndex in
            if emojis.indices.contains($0){
                return EmojiMemoryGame.emojis[$0]
            } else {
                return "?? out of index"
            }
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    var color: Color{
        .orange
    }
    
    // MARK: - Intents
    func shuffle(){
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
    
}
