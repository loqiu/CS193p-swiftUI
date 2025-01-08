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
            ScrollView{
                cards
                    .foregroundColor(viewModel.color)
                    .animation(.easeInOut, value: viewModel.cards)
            }
            Button(action: {
                viewModel.shuffle()
            }, label: {
                Image(systemName: "plus.app.fill")
            })
        }
    }
    
    private var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: aspectRatio){ card in
            CardView(card)
                .padding(spacing)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
    }
}


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
