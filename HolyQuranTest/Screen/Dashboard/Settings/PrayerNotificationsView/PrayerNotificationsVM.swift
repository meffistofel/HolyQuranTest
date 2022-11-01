//
//  PrayerNotificationsVM.swift
//  HolyQuranTest
//
//  Created by Александр Ковалев on 29.10.2022.
//  
//

import SwiftUI

// MARK: - PrayerNotificationsVM

final class PrayerNotificationsVM: ObservableObject {

    // MARK: - Wrapped Properties
    
    @Published var prayerNotificationIsOn: Bool = false
    @Published var selectedPrayer: Prayer = .mockPrayer()

    // MARK: - Properties

    let prayers: [Prayer] = Prayer.get()
    
    private let appState: Store<AppState>

    init(appState: Store<AppState>) {
        self.appState = appState
    }
}

#if DEBUG
extension PrayerNotificationsVM {
    static var preview: PrayerNotificationsVM {
        let appState = Store<AppState>(AppState())
        return .init(
            appState: appState
        )
    }
}
#endif
