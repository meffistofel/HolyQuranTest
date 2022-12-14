//
//  ChartView.swift
//  HolyQuranTest
//
//  Created by Александр Ковалев on 28.10.2022.
//

import SwiftUI

struct BarChartView<Content>: View where Content: View {
    
    let dataPoints: ChartModel
    var spacing: CGFloat
    let content: Content
    
    init(dataPoints: ChartModel, spacing: CGFloat = 39, @ViewBuilder content: () -> Content) {
        self.dataPoints = dataPoints
        self.spacing = spacing
        self.content = content()
    }
    
    var body: some View {
        
        VStack {
            HStack(spacing: 0) {
                Text(dataPoints.section.title)
                    .customFont(.medium, size: 18)
                Spacer()
                Text(dataPoints.section.value)
                    .customFont(.regular, size: 12)
            }
            .padding(.top, 16)
            .padding(.leading, 16)
            .padding(.trailing, 24)
            .padding(.bottom, 23)
            
            content
        }
        .addShadowToRectangle(color: .gray.opacity(0.3), radius: 3, cornerRadius: 20)
    }
}

struct BarView: View {
    
    var dataPoint: MonthDataPoint
    var width: CGFloat
    var isNeedText: Bool
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(.clear)
                    .frame(width: width,
                           height: 93)
                LinearGradient(colors: [.orange, .orange.opacity(0.5), .red], startPoint: .bottom, endPoint: .top)
                    .frame(width: width,
                           height: dataPoint.value * 93.0)
                    .animation(.default, value: dataPoint)
            }
            if isNeedText {
                Text(dataPoint.name)
                    .font(.system(size: 11))
//                    .padding(.bottom, 18)
                
            }
        }
        .padding(.bottom, 18)
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(dataPoints: .init(section: .init(title: "Verses", value: "139 of 160"), model: DataSet.milan)) { EmptyView() }
    }
}

enum Month: String, CaseIterable {
    case jan, feb, mar, apr, may, jun,
         jul, aug, sep, oct, nov, dec,
         jan1, feb2, mar3, apr4, may5, jun6,
         jul7, aug8, sep9, oct10, nov11, dec12,
         jan2, feb3, mar4, apr5, may7, jun8,
         jul9, aug11, sep12, oct3, nov3, dec3
}

struct ChartModel {
    let section: ChartSection
    let model: [MonthDataPoint]
}

struct ChartSection {
    let title: String
    let value: String
}

struct MonthDataPoint: Identifiable, Equatable {
    var id: String { month.rawValue }
    let month: Month
    let value: Double
    var name: String {
        month.rawValue.capitalized
    }
}

extension Array where Element == Double {
    func monthDataPoints() -> [MonthDataPoint] {
        zip(Month.allCases, self)
            .map(MonthDataPoint.init)
    }
}

struct DataSet {
    static let dublin = [
       1, 0.50, 0.55, 0.55, 0.60, 0.65
    ].monthDataPoints()
    
    static let milan = [
        0.65, 0.65, 0.80, 0.80, 0.95, 0.65
    ].monthDataPoints()
    
    static let london = [
        0.55, 0.40, 0.40, 0.45, 0.50, 0.45
    ].monthDataPoints()
    
    static let dublinMonth = [
       1, 0.50, 0.55, 0.55, 0.60,
       1, 0.50, 0.55, 0.55, 0.60,
       1, 0.50, 0.55, 0.55, 0.60,
       1, 0.50, 0.55, 0.55, 0.60,
       1, 0.50, 0.55, 0.55, 0.60,
       1, 0.50, 0.55, 0.55, 0.60,
    ].monthDataPoints()
    
    static let milanMonth = [
        1, 0.50, 0.55, 0.55, 0.60,
        1, 0.50, 0.55, 0.55, 0.60,
        1, 0.50, 0.55, 0.55, 0.60,
        1, 0.50, 0.55, 0.55, 0.60,
        1, 0.50, 0.55, 0.55, 0.60,
        1, 0.50, 0.55, 0.55, 0.60,
    ].monthDataPoints()
    
    static let londonMonth = [
        1, 0.50, 0.55, 0.55, 0.60,
        1, 0.50, 0.55, 0.55, 0.60,
        1, 0.50, 0.55, 0.55, 0.60,
        1, 0.50, 0.55, 0.55, 0.60,
        1, 0.50, 0.55, 0.55, 0.60,
        1, 0.50, 0.55, 0.55, 0.60,
    ].monthDataPoints()
}
