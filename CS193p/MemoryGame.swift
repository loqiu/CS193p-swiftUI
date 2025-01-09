//
//  MemorizeGame.swift
//  CS193p
//  Model
//  Created by 王崇锦 on 07/01/2025.
//
import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    private(set) var score = 0
    
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
                        score += 2 + cards[choseIndex].bonus + cards[potentialMatchIndex].bonus
                    } else {
                        if cards[choseIndex].hasBeenSeen{
                            score -= 1
                        }
                        if cards[potentialMatchIndex].hasBeenSeen {
                            score -= 1
                        }
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
        var isFaceUp: Bool = false {
            didSet{
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
                if oldValue && !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }
        var hasBeenSeen = false
        var isMatched: Bool = false {
            didSet {
                if isMatched {
                    stopUsingBonusTime()
                }
            }
        }
        let content: CardContent
        
        private mutating func startUsingBonusTime() {
            if isFaceUp && !isMatched && bonusPercentRemaining > 0, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
        
        var bonus: Int {
            Int(bonusTimeLimit * bonusPercentRemaining)
        }
        
        var bonusPercentRemaining: Double {
            bonusTimeLimit > 0 ? max(0,bonusTimeLimit - faceUpTime) / bonusTimeLimit : 0
        }
        
        var faceUpTime: TimeInterval {
            if let lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var bonusTimeLimit: TimeInterval = 6
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        var id: String
        var debugDescription: String{
            return "\(id): \(content) \(isFaceUp ? "up":"down") \(isMatched ? "matched":"no matched")"
        }
    }
}


extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
