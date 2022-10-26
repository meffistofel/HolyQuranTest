//
//  More.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 14.10.2022.
//

import Foundation

enum ActionRowType: CaseIterable {
    case none
    case mode
    case colorTheme
    case prayerNotification
    case autoLocation
    case address
    case hourFormat
    case calculationMethod
    case dayVerse
    case achievements
    case zakat

    var title: String {
        switch self {
        case .none:
            return "".localized()
        case .mode:
            return "Mode".localized()
        case .colorTheme:
            return "Color theme".localized()
        case .prayerNotification:
            return "Prayer Notifications".localized()
        case .autoLocation:
            return "Auto-Location".localized()
        case .address:
            return "Tel-Aviv, Israel".localized()
        case .hourFormat:
            return "24 hour format".localized()
        case .calculationMethod:
            return "Calculation Method".localized()
        case .dayVerse:
            return "Verse of the day".localized()
        case .achievements:
            return "Achievements".localized()
        case .zakat:
            return "Zakat".localized()
        }
    }
}
