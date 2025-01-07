//
//  MemorizeGame.swift
//  CS193p
//  Model
//  Created by 王崇锦 on 07/01/2025.
//
import Foundation

struct MemoryGame<CardContent>{
    var cards: Array<Card>
    
    func choose(card: Card){
        
    }
    
    struct Card{
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
    
    struct CardContent{
        
    }
}


