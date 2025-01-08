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
            cards.append(Card(content: cardContent,id: "\(pairIndex+1)a"))
            cards.append(Card(content: cardContent,id: "\(pairIndex+1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int?{
        get{ cards.indices.filter { index in cards[index].isFaceUp }.only }
        set{ cards.indices.forEach {cards[$0].isFaceUp = (newValue == $0)} }
    }
    
    mutating func choose(_ card: Card){
        print("choose card: \(card)")
        if let choseIndex = cards.firstIndex(where: {$0.id == card.id})  {
            if !cards[choseIndex].isFaceUp && !cards[choseIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[choseIndex].content == cards[potentialMatchIndex].content {
                        cards[choseIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = choseIndex
                }
                cards[choseIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
        print("cards test2")
    }
    
    struct Card: Equatable,Identifiable, CustomDebugStringConvertible{
        var debugDescription: String{
            return "\(id): \(content) \(isFaceUp ? "up":"down") \(isMatched ? "matched":"no matched")"
        }
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        let content: CardContent
        
        var id: String
    }
}


extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
