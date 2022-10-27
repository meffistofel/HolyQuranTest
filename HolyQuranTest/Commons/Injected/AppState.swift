//
//  AppState.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 25.08.2022.
//

import SwiftUI
import Combine

struct AppState: Equatable {
    var routing = ViewRouting()
    var system = System()
    var permissions = Permissions()
    var socialSignIn = SocialSignIn()
}

extension AppState {
    struct ViewRouting: Equatable {
        var contentView = ContentView.Routing()
        var home = HomeView.Routing()
        var quran = QuranView.Routing()
        var quibla = QuiblaView.Routing()
        var settings = SettingsView.Routing()
        var discover = DiscoverView.Routing()
        var onboarding = OnboardingView.Routing()
    }
}

extension AppState {
    struct System: Equatable {
        var isActive: Bool = false
        var keyboardHeight: CGFloat = 0
    }
}

extension AppState {
    struct Permissions: Equatable {
        var push: Permission.Status = .unknown
    }

    static func permissionKeyPath(for permission: Permission) -> WritableKeyPath<AppState, Permission.Status> {
        let pathToPermissions = \AppState.permissions
        switch permission {
        case .pushNotifications:
            return pathToPermissions.appending(path: \.push)
        }
    }
}

extension AppState {
    struct SocialSignIn : Equatable {
        var userID: String = ""
        var isLogin: Bool = false

        mutating func logout() {
            userID = ""
            isLogin = false
        }
    }
}

func == (lhs: AppState, rhs: AppState) -> Bool {
    return
        lhs.routing == rhs.routing &&
        lhs.system == rhs.system &&
        lhs.permissions == rhs.permissions
}

extension AppState {
    static var preview: AppState {
        var state = AppState()
        state.system.isActive = true
        return state
    }
}
