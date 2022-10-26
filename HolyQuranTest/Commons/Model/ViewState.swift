//
//  ViewState.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 13.10.2022.
//

import Foundation

enum ViewState {
    case normal
    case select

    var title: String {
        switch self {
        case .normal:
            return "Select"
        case .select:
            return "Delete"
        }
    }
}
