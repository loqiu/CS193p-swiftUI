//
//  MemorizeGame.swift
//  CS193p
//  Model
//  Created by 王崇锦 on 07/01/2025.
//
import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int)->CardContent){
        cards = Array<Card>()
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            //cardContentFactory是一个函数，入参是pairIndex
            let cardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: cardContent))
            cards.append(Card(content: cardContent))
        }
    }
    
    func choose(_ card: Card){
        
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    struct Card: Equatable{
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        let content: CardContent
    }
}


