//
//  SignInVM.swift
//  HolyQuranTest
//
//  Created by Александр Ковалев on 27.10.2022.
//  
//

import SwiftUI

// MARK: - SignInVM
final class SignInVM: ObservableObject {

    // MARK: - Wrapped Properties

    // MARK: - Properties

    private let appState: Store<AppState>

    init(appState: Store<AppState>) {
        self.appState = appState
    }
}

#if DEBUG

extension SignInVM {
    static var preview: SignInVM {
        let appState = Store<AppState>(AppState())
        return .init(
            appState: appState
        )
    }
}

#endif
