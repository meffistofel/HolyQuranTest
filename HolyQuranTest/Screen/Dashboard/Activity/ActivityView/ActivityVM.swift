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
    
    @Published var selectedCity = 0
    @Published var activityState: PickerSelectionState = .weekly

    // MARK: - Properties

    let dataSet = [
        ChartModel(section: ChartSection(title: "Days", value: "Total \(Int.random(in: 1...60)) of 60"), model:  DataSet.dublin),
        ChartModel(section: ChartSection(title: "Minutes", value: "Total \(Int.random(in: 1...60)) of 60"), model:  DataSet.milan),
        ChartModel(section: ChartSection(title: "Verses", value: "Total \(Int.random(in: 1...60)) of 60"), model:  DataSet.london)
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
