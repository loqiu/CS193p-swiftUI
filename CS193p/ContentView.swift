//
//  ContentView.swift
//  CS193p
//
//  Created by 王崇锦 on 04/01/2025.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["🥲","🥸","🤩","🥶","🙂","🥲","🥸","🤩","🥶","🙂"]
    @State var cardCount: Int = 4
    var body: some View {
        VStack{
            ScrollView{
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    

    
    var cardCountAdjusters: some View{
        HStack{
            cardRemover
            Spacer()
            cardAdder
        }
    }
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120, maximum: 120))]){
            ForEach(0..<cardCount, id: \.self){
                index in
                CardView(content:emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.green)
    }
    
    func cardCountAdjusters(by offset: Int, symbol:String) -> some View {
        Button(action:{
            cardCount += offset
        }, label:{
            Image(systemName: symbol)
        })
        .imageScale(.large)
        .font(.largeTitle)
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    var cardRemover: some View{
        cardCountAdjusters(by: -1, symbol: "plus.app.fill")
    }
    var cardAdder: some View{
        cardCountAdjusters(by: +1, symbol: "minus.square.fill")
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

#Preview {
    ContentView()
}
