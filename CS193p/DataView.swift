//
//  DataView.swift
//  CS193p
//
//  Created by 王崇锦 on 09/01/2025.
//
import SwiftUI
import Charts
import SwiftUICharts

struct SwiftUIBarChart: View {
    var body: some View {
        BarChartView(
            data: ChartData(values: [("Jan", 3), ("Feb", 8), ("Mar", 15), ("Apr", 7)]),
            title: "Monthly Sales",
            legend: "2025", // 图表标题和图例
            style: Styles.barChartStyleOrangeLight
        )
    }
}

struct BarChart: View {
    var body: some View {
        Chart {
            BarMark(
                x: .value("Shape Type", data[0].type),
                y: .value("Total Count", data[0].count)
            )
            BarMark(
                 x: .value("Shape Type", data[1].type),
                 y: .value("Total Count", data[1].count)
            )
            BarMark(
                 x: .value("Shape Type", data[2].type),
                 y: .value("Total Count", data[2].count)
            )
        }
    }
}

struct ToyShape: Identifiable {
    var type: String
    var count: Double
    var id = UUID()
}

var data: [ToyShape] = [
    .init(type: "Cube", count: 5),
    .init(type: "Sphere", count: 4),
    .init(type: "Pyramid", count: 4)
]

#Preview {
    SwiftUIBarChart()
}
