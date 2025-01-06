//
//  ContentView.swift
//  CS193p
//
//  Created by 王崇锦 on 04/01/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack{
            CardView(isFlag: true)
            CardView()
            CardView(isFlag: true)
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View{
    @State var isFlag = false
    
    var body: some View {
        ZStack{
            let base = Circle()
            if isFlag{
                base.foregroundColor(.gray)
                Text("🙄🫥").font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 12)
            }
        }
        .onTapGesture{
            print("tapped2")
            isFlag = !isFlag
        }
        Button("Toggle Flag") {
            isFlag.toggle()  // 修改状态
        }
        
        
    }
}

#Preview {
    ContentView()
}
