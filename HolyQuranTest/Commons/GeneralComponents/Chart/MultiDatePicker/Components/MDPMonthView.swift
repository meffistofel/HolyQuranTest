//
//  MonthView.swift
//  MultiDatePickerApp
//
//  Created by Peter Ent on 11/2/20.
//

import SwiftUI

/**
 * MDPMonthView is really the crux of the control. This displays everything and handles the interactions
 * and selections. MulitDatePicker is the public interface that sets up the model and this view.
 */
struct MDPMonthView: View {
    @EnvironmentObject var monthDataModel: MDPModel
        
    @State private var showMonthYearPicker = false
    @State private var testDate = Date()
    
    private func showPrevMonth() {
        withAnimation {
            monthDataModel.decrMonth()
            showMonthYearPicker = false
        }
    }
    
    private func showNextMonth() {
        withAnimation {
            monthDataModel.incrMonth()
            showMonthYearPicker = false
        }
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                
                Text("Days")
                    .customFont(.medium, size: 14)
                
                Spacer()
                
                Button {
                    showPrevMonth()
                } label: {
                    Image(systemName: "chevron.left")
                        .renderingMode(.template)
                        .foregroundColor(.gray)
                        .customFont(.light, size: 16)
                }
                .padding(.trailing, 12)

                
                MDPMonthYearPickerButton(isPresented: self.$showMonthYearPicker)
                
                Button {
                    showNextMonth()
                } label: {
                    Image(systemName: "chevron.right")
                        .renderingMode(.template)
                        .foregroundColor(.gray)
                        .customFont(.light, size: 16)
                }
                .padding(.leading, 12)
                .padding(.trailing, 16)
            }
            .padding(.leading, 22)
            .padding(.top, 25)
            
            Divider()
                .padding(.top, 8)
                .padding(.bottom, 24)
                .padding(.horizontal, 22)
            
                VStack {
                    if showMonthYearPicker {
                        MDPMonthYearPicker(date: monthDataModel.controlDate) { (month, year) in
                            self.monthDataModel.show(month: month, year: year)
                        }
                    } else {
                        let size = (UIScreen.main.bounds.width - 76) / 7
                        MDPContentView(parentSize: size)
                    }
                }
            .padding(.bottom, 24)
            .padding(.leading, 16)
            .padding(.trailing, 21)
        }
        .addShadowToRectangle(color: .gray.opacity(0.3), radius: 4, cornerRadius: 19)
//        .background(
//            RoundedRectangle(cornerRadius: 19)
//                .foregroundColor(.white)
//        )
//        .padding()
        .frame(width: .infinity)
    }
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MDPMonthView()
            .environmentObject(MDPModel())
    }
}
