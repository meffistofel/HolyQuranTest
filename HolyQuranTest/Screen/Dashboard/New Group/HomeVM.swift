//
//  HomeVM.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 25.10.2022.
//  
//

import SwiftUI

// MARK: - HomeVM
final class HomeVM: ObservableObject {

    // MARK: - Wrapped Properties

    // MARK: - Properties

    private let appState: Store<AppState>

    init(appState: Store<AppState>) {
        self.appState = appState
    }
}

#if DEBUG

extension HomeVM {
    static var preview: HomeVM {
        let appState = Store<AppState>(AppState())
        return .init(
            appState: appState
        )
    }
}

#endif
