//
//  MultiDatePicker.swift
//  HolyQuranTest
//
//  Created by Александр Ковалев on 31.10.2022.
//

import SwiftUI

struct MultiDatePicker: View {
    
    // the type of picker, based on which init() function is used.
    enum PickerType {
        case singleDay
        case anyDays
        case dateRange
    }
    
    // lets all or some dates be elligible for selection.
    enum DateSelectionChoices {
        case allDays
        case weekendsOnly
        case weekdaysOnly
    }
    
    @StateObject var monthModel: MDPModel
        
    // selects only a single date
    
    init(singleDay: Binding<Date>,
         includeDays: DateSelectionChoices = .allDays,
         minDate: Date? = nil,
         maxDate: Date? = nil
    ) {
        _monthModel = StateObject(wrappedValue: MDPModel(singleDay: singleDay, includeDays: includeDays, minDate: minDate, maxDate: maxDate))
    }
    
    // selects any number of dates, non-contiguous
    
    init(anyDays: Binding<[Date]>,
         includeDays: DateSelectionChoices = .allDays,
         minDate: Date? = nil,
         maxDate: Date? = nil
    ) {
        _monthModel = StateObject(wrappedValue: MDPModel(anyDays: anyDays, includeDays: includeDays, minDate: minDate, maxDate: maxDate))
    }
    
    // selects a closed date range
    
    init(dateRange: Binding<ClosedRange<Date>?>,
         includeDays: DateSelectionChoices = .allDays,
         minDate: Date? = nil,
         maxDate: Date? = nil
    ) {
        _monthModel = StateObject(wrappedValue: MDPModel(dateRange: dateRange, includeDays: includeDays, minDate: minDate, maxDate: maxDate))
    }
    
    var body: some View {
        MDPMonthView()
            .environmentObject(monthModel)
    }
}

struct MultiDatePicker_Previews: PreviewProvider {
    @State static var oneDay = Date()
    @State static var manyDates = [Date]()
    @State static var dateRange: ClosedRange<Date>? = nil
    
    static var previews: some View {
        ScrollView {
            VStack {
                MultiDatePicker(singleDay: $oneDay, includeDays: .weekdaysOnly)
                MultiDatePicker(anyDays: $manyDates, includeDays: .weekendsOnly)
                MultiDatePicker(dateRange: $dateRange)
            }
        }
    }
}

