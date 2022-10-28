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

    // MARK: - Properties

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
