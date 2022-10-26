//
//  OnboardingVM.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 26.10.2022.
//  
//

import SwiftUI

// MARK: - OnboardingVM
final class OnboardingVM: ObservableObject {

    // MARK: - Wrapped Properties

    // MARK: - Properties

    private let appState: Store<AppState>

    init(appState: Store<AppState>) {
        self.appState = appState
    }
}

#if DEBUG

extension OnboardingVM {
    static var preview: OnboardingVM {
        let appState = Store<AppState>(AppState())
        return .init(
            appState: appState
        )
    }
}

#endif
