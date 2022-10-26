//
//  QuiblaVM.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 26.10.2022.
//  
//

import SwiftUI

// MARK: - QuiblaVM
final class QuiblaVM: ObservableObject {

    // MARK: - Wrapped Properties
    @Published var selectedIndex: Int = 1

    // MARK: - Properties

    private let appState: Store<AppState>

    init(appState: Store<AppState>) {
        self.appState = appState
    }
}

#if DEBUG

extension QuiblaVM {
    static var preview: QuiblaVM {
        let appState = Store<AppState>(AppState())
        return .init(
            appState: appState
        )
    }
}

#endif
