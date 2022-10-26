//
//  InputType.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 29.08.2022.
//

import SwiftUI

enum InputType {
    case none

    var placeholder: String {
        switch self {
        case .none:
            return ""
        }
    }

    var prompt: String {
        switch self {
        case .none:
            return ""
        }
    }

    var errorMessage: String {
        switch self {
        case .none:
            return ""
        }
    }

    var backgroundColor: Color {
        return .white
    }

    func getImage(isSecure: Bool = false) -> String {
        switch self {
//        case .none:
//            return isSecure ? Constants.Image.icoTextFieldNotVisibility : Constants.Image.icoTextFieldVisibility
//        case .none
//            return Constants.Image.icoTextFieldRightArrowGray
        case .none:
            return ""
        }
    }

    var foregroundColor: Color {
        return .black
    }

    var maxCharacter: Int {
        return 255
    }

    var keyboardType: UIKeyboardType {
        switch self {
        case .none:
            return .phonePad
//        case .emailAddress:
//            return .emailAddress
//        case .commercialRegNumber, .fromMileage, .toMileage, .fromPrice, .toPrice:
//            return .numberPad
//        default:
//            return .default
        }
    }

    var capitalization: UITextAutocapitalizationType {
        return .none
    }

    var errorImage: String {
        return ""
//        return Constants.Image.icoTextFieldValidateError
    }

    var disabled: Bool {
        switch self {
        case .none:
            return true
        default:
            return false
        }
    }

    func isValid(with text: String) -> Bool {
        switch self {
        case .none:
            return false
        default:
            return true
        }
    }
}
