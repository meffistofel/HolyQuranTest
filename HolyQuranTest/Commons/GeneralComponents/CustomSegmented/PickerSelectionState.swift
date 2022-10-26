//
//  PickerSelectionState.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 31.08.2022.
//

import Foundation

enum PickerSelectionState {
    case surah
    case juz
    case bookmarks
    case map
    case compass

    var title: String {
        switch self {
        case .surah:
            return "Surah".localized()
        case .juz:
            return "Juz".localized()
        case .bookmarks:
            return "Bookmarks".localized()
        case .map:
            return "Map".localized()
        case .compass:
            return "Compass".localized()
        }
    }
}
