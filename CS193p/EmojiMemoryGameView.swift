//
//  ContentView.swift
//  CS193p
//  View
//  Created by 王崇锦 on 04/01/2025.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    var viewModel: EmojiMemoryGame
    
    let emojis: Array<String> = ["🥲","🥸","🤩","🥶","🙂","🥲","🥸","🤩","🥶","🙂"]

    var body: some View {
        ScrollView{
            cards
        }
        .padding()
    }
    
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120, maximum: 120))]){
            ForEach(emojis.indices, id: \.self){
                index in
                CardView(content:emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.green)
    }
}

struct CardView: View{
    let content: String
    @State var isFlag = true
    var body: some View {
        ZStack{
            let base = Circle()
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            }
            .opacity(isFlag ? 1 : 0)
            base.fill().opacity(isFlag ? 0 : 1)
        }
        .onTapGesture{
            print("zstack ontapgesture")
            isFlag.toggle()
        }
    }
}

struct CardsArray<Element> where Element: Equatable{
    
}

#Preview {
    EmojiMemoryGameView()
}
