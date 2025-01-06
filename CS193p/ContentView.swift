//
//  ContentView.swift
//  CS193p
//
//  Created by 王崇锦 on 04/01/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
    let emojis: Array<String> = ["🥲","🥸","🤩"]
        HStack{
            ForEach(emojis.indices, id: \.self){
                index in
                CardView(content:emojis[index])
            }
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View{
    let content: String
    @State var isFlag = true
    var body: some View {
        ZStack{
            let base = Circle()
            if isFlag{
                base.foregroundColor(.gray)
                Text(content).font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 12)
            }
        }
        .onTapGesture{
            print("zstack ontapgesture")
            isFlag = !isFlag
        }
        Button("Toggle Flag") {
            print("button toggle flag")
            isFlag.toggle()  // 修改状态
        }
        
        
    }
}

#Preview {
    ContentView()
}
