//
//  DiscoverVM.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 26.10.2022.
//  
//

import SwiftUI

// MARK: - DiscoverVM
final class DiscoverVM: ObservableObject {

    // MARK: - Wrapped Properties

    // MARK: - Properties

    private let appState: Store<AppState>

    init(appState: Store<AppState>) {
        self.appState = appState
    }
}

#if DEBUG

extension DiscoverVM {
    static var preview: DiscoverVM {
        let appState = Store<AppState>(AppState())
        return .init(
            appState: appState
        )
    }
}

#endif
