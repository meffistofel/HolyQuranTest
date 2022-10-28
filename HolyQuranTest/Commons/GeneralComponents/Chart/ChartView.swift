//
//  ChartView.swift
//  HolyQuranTest
//
//  Created by Александр Ковалев on 28.10.2022.
//

import SwiftUI

struct BarChartView: View {
    var dataPoints: [MonthDataPoint]
    
    var body: some View {
        
        VStack {
            HStack(spacing: 0) {
                CustomText(text: "Verses", font: (.medium, 18), foregroundColor: .black)
                Spacer()
                CustomText(text: "Total 45 of 60", font: (.regular, 12), foregroundColor: .black)
            }
            .padding(.top, 16)
            .padding(.leading, 16)
            .padding(.trailing, 24)
            .padding(.bottom, 23)
            
            HStack (spacing: 39) {
                ForEach(dataPoints) {
                    BarView(dataPoint: $0)
                }
            }
        }
        .addShadowToRectangle(color: .gray.opacity(0.3), radius: 3, cornerRadius: 20)
    }
}

struct BarView: View {
    var dataPoint: MonthDataPoint
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 5,
                           height: 93)
                LinearGradient(colors: [.orange, .orange.opacity(0.5), .red], startPoint: .bottom, endPoint: .top)
//                    .fill(.blue)
                    .frame(width: 5,
                           height: dataPoint.value * 93.0)
                    .animation(.default, value: dataPoint)
            }
            Text(dataPoint.name)
                .font(.system(size: 11))
                .padding(.bottom, 18)
        }
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView(dataPoints: DataSet.dublin)
    }
}

enum Month: String, CaseIterable {
    case jan, feb, mar, apr, may, jun,
         jul, aug, sep, oct, nov, dec
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
}
