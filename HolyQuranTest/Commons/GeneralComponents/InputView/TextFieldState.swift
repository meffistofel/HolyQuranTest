//
//  TextFieldState.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 30.08.2022.
//

import SwiftUI

enum TextFieldState {
    case normal
    case valid
    case editing
    case error

    var style: Style {
        switch self {
        case .normal, .valid:
            return Style(borderWidth: 1, borderColor: .gray, promtColor: .gray)
        case .editing:
            return Style(borderWidth: 1, borderColor: .black, promtColor: .gray)
        case .error:
            return Style(borderWidth: 1, borderColor: .red, promtColor: .red)
        }
    }

    struct Style {

        let borderWidth: CGFloat
        let borderColor: Color
        let promtColor: Color
    }
}
