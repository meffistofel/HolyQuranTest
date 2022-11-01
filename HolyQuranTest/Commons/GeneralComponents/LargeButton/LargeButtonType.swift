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
    case cancel
    case logOut
    case setGoals

    // Change & Forgot Password
    case changePassword
    case goToSigIn

    //Terms
    case accept

    //Dashboard
    case search
    case next
    case back
    
    case prayerSound

    var title: String {
        switch self {
        case .setGoals:
            return "Set  goals".localized()
        case .cancel:
            return "CANCEL".localized()
        case .done:
            return "DONE".localized()
        case .accept:
            return "Accept".localized()
        case .reset:
            return "Reset".localized()
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
        case .prayerSound:
            return ""
        }
    }

    var isNeedBorder: Bool {
        switch self {
        case .cancel, .prayerSound:
            return true
        default:
            return false
        }
    }

    var isNeedGradient: Bool {
        return false
    }

    var foregroundColor: Color {
        switch self {
        case .cancel:
            return .gray
        default:
            return .white
        }
    }
}
