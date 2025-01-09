//
//  AspectVGrid.swift
//  CS193p
//  View
//  Created by 王崇锦 on 08/01/2025.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View{
    var items: [Item]
    var aspectRatio: CGFloat = 2/3
    var content: (Item) -> ItemView
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)],spacing: 0){
                ForEach(items){
                    item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
        // MARKED - set height
//        .frame(height: 700)
    }
    
    
    func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        print(min(size.width / count,size.height * aspectRatio).rounded(.down))
        return min(size.width / count,size.height * aspectRatio).rounded(.down)
    }
}
