//
//  LargeButtonType.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 29.08.2022.
//

import SwiftUI

enum LargeButtonType {
    // MARK: - SignIn & SignUp

    // Sign In & Sign Up
    case signIn
    case signUp
    case reset
    case done
    case logOut

    // Change & Forgot Password
    case changePassword
    case goToSigIn

    //Terms
    case accept

    //Dashboard
    case search
    case next
    case back

    var title: String {
        switch self {
        case .accept:
            return "Accept".localized()
        case .reset:
            return "Reset".localized()
        case .done:
            return "Done".localized()
        case .changePassword:
            return "Change Password".localized()
        case .goToSigIn:
            return "Go to Sign In".localized()
        case .search:
            return "Search".localized()
        case .next:
            return "Next".localized()
        case .back:
            return "Back".localized()
        case .signIn:
            return "Sign In".localized()
        case .signUp:
            return "Sign Up".localized()
        case .logOut:
            return "Log Out".localized()
        }
    }

    var isNeedBorder: Bool {
        return false
    }

    var isNeedGradient: Bool {
        return false
    }

    var backgroundColor: Color {
        return .clear

    }

    var foregroundColor: Color {
        return .black
    }
}
