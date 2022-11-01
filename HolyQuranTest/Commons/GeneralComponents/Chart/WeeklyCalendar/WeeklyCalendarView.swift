//
//  WeeklyCalendar.swift
//  HolyQuranTest
//
//  Created by Александр Ковалев on 30.10.2022.
//

import SwiftUI
import Foundation

struct WeeklyCalendar: View {
    
    private let calendar: Calendar
    private let monthDayFormatter: DateFormatter
    private let dayFormatter: DateFormatter
    private let weekDayFormatter: DateFormatter
    
    @State private var selectedDate = Date()

//    private static var now = Date()
    
    init(calendar: Calendar) {
        self.calendar = calendar
        self.monthDayFormatter = DateFormatter(dateFormat: "MM/dd", calendar: calendar)
        self.dayFormatter = DateFormatter(dateFormat: "d", calendar: calendar)
        self.weekDayFormatter = DateFormatter(dateFormat: "EEEEE", calendar: calendar)
    }
    
    var body: some View {
        WeeklyCalendarView(date: $selectedDate, calendar: calendar) { date in
            Button {
                selectedDate = date
            } label: {
                Text("00")
                    .customFont(.semibold, size: 16)
                    .padding(6)
                    .foregroundColor(.clear)
                    .overlay(
                        Text(dayFormatter.string(from: date))
                            .foregroundColor(calendar.isDate(date, inSameDayAs: selectedDate) ? .black : (calendar.isDateInToday(date) ? .gray : .gray) )
                    )
                    .background(
                        Circle()
                            .foregroundColor(.blue)
                            .opacity(calendar.isDate(date, inSameDayAs: selectedDate) ? 1 : 0)
//
                    )
                    .fixedSize()
            }
        } header: { date in
            Text("00")
                .customFont(.medium, size: 16)
                .padding(6)
                .foregroundColor(.clear)
                .overlay {
                    Text(weekDayFormatter.string(from: date))
                        .customFont(.medium, size: 16)
                        
                }.fixedSize()
        } title: { date in
            ContentWithSpacer(contentAlignment: .leading) {
                Text(monthDayFormatter.string(from: selectedDate))
            }
        } weekSwitcher: { date in
            Button {
                
            } label: {
                Label {
                    Text("Previous")
                } icon: {
                    Image(systemName: "chevron.left")
                }

            }

        }
        
    }
}

struct WeeklyCalendar_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyCalendar(calendar: Calendar(identifier: .gregorian))
    }
}

struct WeeklyCalendarView<Day: View, Header: View, Title: View, WeekSwiter: View>: View {
    
    private var spacing: CGFloat {
        UIScreen.main.bounds.width / 7 - 40
    }
    
    @Binding private var date: Date
    
    private var calendar: Calendar
    private let content: ViewBuilderClosure<Date, Day>
    private let header: ViewBuilderClosure<Date, Header>
    private let title: ViewBuilderClosure<Date, Title>
    private let weekSwitcher: ViewBuilderClosure<Date, WeekSwiter>
    
    private let daysInWeek = 7
    
    init(
        date: Binding<Date> ,
        calendar: Calendar,
        @ViewBuilder content: @escaping ViewBuilderClosure<Date, Day>,
        @ViewBuilder header: @escaping ViewBuilderClosure<Date, Header>,
        @ViewBuilder title: @escaping ViewBuilderClosure<Date, Title>,
        @ViewBuilder weekSwitcher: @escaping ViewBuilderClosure<Date, WeekSwiter>
    ) {
        self._date = date
        self.calendar = calendar
        self.content = content
        self.header = header
        self.title = title
        self.weekSwitcher = weekSwitcher
    }
    
    var body: some View {
        let month = date.startOfMonth(using: calendar)
        let days = makeDays()
        VStack(spacing: 16) {
//            HStack {
//                title(month)
//                weekSwitcher(month)
//            }
            HStack(spacing: spacing) {
                ForEach(days.prefix(daysInWeek), id: \.self, content: header)
            }
            
            HStack(spacing: spacing) {
                ForEach(days, id: \.self) { day in
                    content(day)
                }
            }
        }
//        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

extension WeeklyCalendarView {
    func makeDays() -> [Date] {
        guard let firstWeek = calendar.dateInterval(of: .weekOfMonth, for: date),
              let lastWeek = calendar.dateInterval(of: .weekOfMonth, for: firstWeek.end - 1) else {
            return []
        }
        
        let dateInterval = DateInterval(start: firstWeek.start, end: lastWeek.end)
        
        return calendar.generateDays(for: dateInterval)
    }
}

extension Calendar {
    func generateDates(
        for dateInterval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates = [dateInterval.start]
        
        enumerateDates(
            startingAfter: dateInterval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            guard let date else {
                return
            }
            
            guard date < dateInterval.end else {
                stop = true
                return
            }
            
            dates.append(date)
        }
        
        return dates
    }
    
    func generateDays(for dateInterval: DateInterval) -> [Date] {
        generateDates(for: dateInterval, matching: dateComponents([.hour, .minute, .second], from: dateInterval.start))
    }
}

private extension Date {
    func startOfMonth(using calendar: Calendar) -> Date {
        calendar.date(from: calendar.dateComponents([.year, .month], from: self)) ?? self
    }
    
}

private extension DateFormatter {
    convenience init(dateFormat: String, calendar: Calendar) {
        self.init()
        self.dateFormat = dateFormat
        self.calendar = calendar
        self.locale = Locale(identifier: "js_JP")
    }
}
