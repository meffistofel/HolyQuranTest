//
//  PrayerSoundVM.swift
//  HolyQuranTest
//
//  Created by Александр Ковалев on 30.10.2022.
//  
//

import SwiftUI

// MARK: - PrayerSoundVM
final class PrayerSoundVM: ObservableObject {

    // MARK: - Wrapped Properties
    @Published var prayer: Prayer = .mockPrayer()
    @Published var preNotificationIsOn: Bool = false
    @Published var minutes: Int = 0

    // MARK: - Properties

    private let appState: Store<AppState>

    init(appState: Store<AppState>, prayer: Prayer) {
        self.appState = appState
        self.prayer = prayer
    }
}

#if DEBUG

extension PrayerSoundVM {
    static var preview: PrayerSoundVM {
        let appState = Store<AppState>(AppState())
        return .init(
            appState: appState,
            prayer: .mockPrayer()
        )
    }
}

#endif
