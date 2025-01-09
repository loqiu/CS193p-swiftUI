//
//  Cardify.swift
//  CS193p
//
//  Created by 王崇锦 on 08/01/2025.
//
import SwiftUI

struct Cardify: ViewModifier, Animatable {
    init(isFaceUp: Bool){
        rotation = isFaceUp ? 0 : 180
    }
    var isFaceUp: Bool {
        rotation < 90
    }
    var rotation: Double
    var animatableData: Double{
        get{return rotation}
        set{rotation = newValue}
    }
    
    func body(content: Content) -> some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.strokeBorder(lineWidth: 3)
                .background(base.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            base.fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (0,1,0))
    }
    
    private struct Constants {
        static let cornerRadius:CGFloat = 12
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
