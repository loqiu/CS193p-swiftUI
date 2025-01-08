//
//  CardView.swift
//  CS193p
//
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
        ZStack{
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(5)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
    
    private struct Constants{
        static let cornerRadius:CGFloat = 12
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
