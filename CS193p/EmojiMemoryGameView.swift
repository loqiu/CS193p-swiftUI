//
//  ContentView.swift
//  CS193p
//  View
//  Created by 王崇锦 on 04/01/2025.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    
    var body: some View {
        VStack{
            cards
                .foregroundColor(viewModel.color)
            HStack{
                score
                Spacer()
                shuffle
            }
            .font(.largeTitle)
        }
        .padding(5)
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var shuffle: some View {
        Button(action: {
            withAnimation(.interactiveSpring(response: 1,dampingFraction: 0.5)){
                viewModel.shuffle()
            }
        }, label: {
            Image(systemName: "plus.app.fill")
        })
    }
    
    private var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: aspectRatio){ card in
            if isDealt(card){
                CardView(card)
                    .padding(spacing)
                    .overlay(FlyingNumber(number: scoreChange(causeBy: card)))
                    .zIndex(scoreChange(causeBy: card) != 0 ? 1 : 0)
                    .onTapGesture {
                        choose(card)
                    }
                    .transition(.offset(
                        x: CGFloat.random(in: -1000...1000),
                        y: CGFloat.random(in: -1000...1000)
                    ))
            }
        }
        .onAppear(){
            // deal the cards
            withAnimation(.easeInOut(duration: 2)) {
                for card in viewModel.cards {
                    dealt.insert(card.id)
                }
            }
        }
    }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card:Card)-> Bool {
        dealt.contains(card.id)
    }
    private var undealCards: [Card] {
        viewModel.cards.filter() {!isDealt($0)}
    }
    
    private func choose(_ card: Card){
        withAnimation {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange,causedByCardId: card.id)
        }
    }
    
    @State private var lastScoreChange = (amount:0, causedByCardId: "")
    
    private func scoreChange(causeBy card: Card) -> Int {
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
        //equses return lastScoreChange.1 == card.id ? lastScoreChange.0 : 0
    }
}


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
