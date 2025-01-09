//
//  CardView.swift
//  CS193p
//  View
//  Created by 王崇锦 on 08/01/2025.
//

import SwiftUI

struct CardView: View{
    typealias Card = MemoryGame<String>.Card
    
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    var body: some View {
        TimelineView(.animation) {
            timeline in
            if card.isFaceUp || !card.isMatched {
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                    .opacity(0.4)
                    .overlay(cardContents.padding(5))
                    .padding(5)
                    .cardify(isFaceUp: card.isFaceUp)
                    .transition(.opacity)
            } else {
                Color.clear
            }
        }
    }
    
    var cardContents: some View {
        Text(card.content)
            .font(.system(size: 200))
            .minimumScaleFactor(0.01)
            .multilineTextAlignment(.center)
            .aspectRatio(1, contentMode: .fit)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(duration: 1), value: card.isMatched)
    }
    
    private struct Constants{
        static let cornerRadius:CGFloat = 12
    }
}

extension Animation{
    static func spin(duration: TimeInterval) -> Animation{
        .linear(duration: 1).repeatForever(autoreverses: false)
    }
}

#Preview {
//    typealias Card = MemoryGame<String>.Card 不再支持
    VStack{
        HStack{
            CardView(MemoryGame<String>.Card(isFaceUp:true,content: "X", id: "test1"))
            CardView(MemoryGame<String>.Card(content: "X", id: "test1"))
        }
        HStack{
            CardView(MemoryGame<String>.Card(isFaceUp:true,isMatched: true,content: "X", id: "test1"))
            CardView(MemoryGame<String>.Card(isMatched: true,content: "X", id: "test1"))
        }
    }
        .padding()
        .foregroundColor(.green)
}
