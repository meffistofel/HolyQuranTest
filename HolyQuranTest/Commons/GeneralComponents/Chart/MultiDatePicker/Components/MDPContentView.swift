//
//  MonthContentView.swift
//  MultiDatePickerApp
//
//  Created by Peter Ent on 11/3/20.
//

import SwiftUI

/**
 * Displays the calendar of MDPDayOfMonth items using MDPDayView views.
 */
struct MDPContentView: View {
    @EnvironmentObject var monthDataModel: MDPModel
    
    let cellSize: CGFloat = 30
    
    var columns: [GridItem] = []
    
    init(parentSize: CGFloat) {
        
        columns = [ GridItem(.fixed(parentSize), spacing: 0),
                    GridItem(.fixed(parentSize), spacing: 0),
                    GridItem(.fixed(parentSize), spacing: 0),
                    GridItem(.fixed(parentSize), spacing: 0),
                    GridItem(.fixed(parentSize), spacing: 0),
                    GridItem(.fixed(parentSize), spacing: 0),
                    GridItem(.fixed(parentSize), spacing: 0)
        ]
    }
    
    var body: some View {
        
        LazyVGrid(columns: columns, spacing: 10) {
            
            // Sun, Mon, etc.
            ForEach(0..<monthDataModel.dayNames.count, id: \.self) { index in
                Text(monthDataModel.dayNames[index].uppercased().prefix(1))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 10)
            
            // The actual days of the month.
            ForEach(0..<monthDataModel.days.count, id: \.self) { index in
                if monthDataModel.days[index].day == 0 {
                    Text("")
                        .frame(minHeight: 0, maxHeight: 0)
                } else {
                    MDPDayView(dayOfMonth: monthDataModel.days[index])
                }
            }
        }.padding(.bottom, 0)
    }
}

struct MonthContentView_Previews: PreviewProvider {
    static var previews: some View {
        MDPContentView(parentSize: 48)
            .environmentObject(MDPModel())
    }
}
