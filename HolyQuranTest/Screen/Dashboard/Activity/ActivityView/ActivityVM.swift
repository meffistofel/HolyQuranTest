//
//  ActivityVM.swift
//  HolyQuranTest
//
//  Created by Александр Ковалев on 28.10.2022.
//  
//

import SwiftUI

// MARK: - ActivityVM
final class ActivityVM: ObservableObject {

    // MARK: - Wrapped Properties
    
    @Published var activity = 0
    @Published var selectedMonthDate: [Date] = []

    // MARK: - Properties

    let dataSetWeekly = [
        ChartModel(section: ChartSection(title: "Days", value: "Total \(Int.random(in: 1...60)) of 60"), model:  DataSet.dublin),
        ChartModel(section: ChartSection(title: "Minutes", value: "Total \(Int.random(in: 1...60)) of 60"), model:  DataSet.milan),
        ChartModel(section: ChartSection(title: "Verses", value: "Total \(Int.random(in: 1...60)) of 60"), model:  DataSet.london)
    ]
    
    let dataSetMonthly = [
        ChartModel(section: ChartSection(title: "Days", value: "Total \(Int.random(in: 1...60)) of 60"), model:  DataSet.dublinMonth),
        ChartModel(section: ChartSection(title: "Minutes", value: "Total \(Int.random(in: 1...60)) of 60"), model:  DataSet.milanMonth),
        ChartModel(section: ChartSection(title: "Verses", value: "Total \(Int.random(in: 1...60)) of 60"), model:  DataSet.londonMonth)
    ]
    private let appState: Store<AppState>

    init(appState: Store<AppState>) {
        self.appState = appState
    }
}

#if DEBUG

extension ActivityVM {
    static var preview: ActivityVM {
        let appState = Store<AppState>(AppState())
        return .init(
            appState: appState
        )
    }
}

#endif
