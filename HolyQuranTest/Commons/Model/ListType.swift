//
//  ListType.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 12.10.2022.
//

import Foundation

enum ListType {

    case none

    var navTitle: String {
        switch self {
        case .none:
            return ""
        }
    }

    var buttonType: RadioButtonType {
        switch self {
        case .none:
            return .none
        }
    }
}
