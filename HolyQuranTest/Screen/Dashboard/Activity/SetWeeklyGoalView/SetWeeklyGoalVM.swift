//
//  SetWeeklyGoalVM.swift
//  HolyQuranTest
//
//  Created by Александр Ковалев on 28.10.2022.
//  
//

import SwiftUI

// MARK: - SetWeeklyGoalVM
final class SetWeeklyGoalVM: ObservableObject {

    // MARK: - Wrapped Properties

    // MARK: - Properties
    @Published var daysPerWeek: Double = 3
    @Published var turnPushNotification: Bool = false

    private let appState: Store<AppState>

    init(appState: Store<AppState>) {
        self.appState = appState
    }
}

#if DEBUG

extension SetWeeklyGoalVM {
    static var preview: SetWeeklyGoalVM {
        let appState = Store<AppState>(AppState())
        return .init(
            appState: appState
        )
    }
}

#endif
