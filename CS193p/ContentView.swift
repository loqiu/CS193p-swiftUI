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
            CardView(isFalg: true)
            CardView()
            CardView(isFalg: true)
        }
        .foregroundColor(.green)
        .padding()
    }
}

struct CardView: View{
    var isFalg:Bool = false
    var body: some View {
        if isFalg{
            ZStack(content: {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.blue)
                Text("🙄").font(.largeTitle)
            })
        } else {
            RoundedRectangle(cornerRadius: 12)
        }
        
    }
}

#Preview {
    ContentView()
}
