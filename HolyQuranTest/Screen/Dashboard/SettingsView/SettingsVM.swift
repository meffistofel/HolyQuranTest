//
//  SettingsVM.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 26.10.2022.
//  
//

import SwiftUI

// MARK: - SettingsVM
final class SettingsVM: ObservableObject {

    // MARK: - Wrapped Properties
    @Published var autoLocation: Bool = false
    @Published var hourFormat: Bool = false
    @Published var dayVerse: Bool = false
    @Published var achievements: Bool = false

    // MARK: - Properties

    private let appState: Store<AppState>

    init(appState: Store<AppState>) {
        self.appState = appState
    }
}

#if DEBUG

extension SettingsVM {
    static var preview: SettingsVM {
        let appState = Store<AppState>(AppState())
        return .init(
            appState: appState
        )
    }
}

#endif
