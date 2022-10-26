//
//  QuranVM.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 25.10.2022.
//  
//

import SwiftUI

struct QuranVerse: Identifiable {
    let id: UUID = UUID()
    let name: String
}

// MARK: - QuranVM
final class QuranVM: ObservableObject {

    // MARK: - Wrapped Properties

    @Published var pickerState: PickerSelectionState = .surah
    @Published var selectedIndex: Int = 0

    // MARK: - Properties

    private let appState: Store<AppState>

    init(appState: Store<AppState>) {
        self.appState = appState
    }
}

#if DEBUG

extension QuranVM {
    static var preview: QuranVM {
        let appState = Store<AppState>(AppState())
        return .init(
            appState: appState
        )
    }
}

#endif
