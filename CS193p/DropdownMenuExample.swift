//
//  DropdownMenuExample.swift
//  CS193p
//
//  Created by 王崇锦 on 09/01/2025.
//
import SwiftUI

struct DropdownMenuExample: View {
    @State private var isMenuOpen = false // 管理菜单的展开/收起状态

    var body: some View {
        VStack {
            // 顶部右上角的箭头按钮
            HStack {
                Spacer()
                // 按钮和菜单逻辑
                VStack(alignment: .trailing, spacing: 5) {
                    Button(action: {
                        withAnimation {
                            isMenuOpen.toggle() // 切换菜单状态
                        }
                    }) {
                        HStack(spacing: 5) {
                            Text("Menu")
                            Image(systemName: isMenuOpen ? "chevron.up" : "chevron.down") // 动态箭头
                        }
                    }

                    // 下拉菜单
                    if isMenuOpen {
                        VStack(alignment: .trailing, spacing: 10) {
                            Button("Option 1", action: { print("Option 1 clicked") })
                            Button("Option 2", action: { print("Option 2 clicked") })
                            Button("Option 3", action: { print("Option 3 clicked") })
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadow(radius: 10)
                        .frame(maxWidth: 200)
                        .transition(.move(edge: .top)) // 动画效果
                    }
                }
            }
            .padding()
            
            Spacer() // 主内容分隔
        }
        .background(
            // 点击背景关闭菜单
            Color.gray.opacity(isMenuOpen ? 0.1 : 0.0)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation {
                        isMenuOpen = false
                    }
                }
        )
    }
}

#Preview {
    DropdownMenuExample()
}
