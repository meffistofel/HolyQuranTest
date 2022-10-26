//
//  DependencyConst.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 24.08.2022.
//

import Foundation
import SwiftUI

struct DependencyContainer: EnvironmentKey {

    let appState: Store<AppState>
    let webRepositories: DependencyContainer.WebRepositories
    let loginService: LoginService
    let googleLoginService: GoogleLoginService

    init() {
        self.appState = Store<AppState>(AppState())
        self.webRepositories = DependencyContainer.configuredWebRepositories()
        self.loginService = LoginService(appState: appState)
        self.googleLoginService = GoogleLoginService(appState: appState)
    }

    static var defaultValue: Self { Self.default }

    private static let `default` = Self()
}

// MARK: - Private Extension

private extension DependencyContainer {
    static func configuredWebRepositories() -> DependencyContainer.WebRepositories {

        let session = configuredURLSession()
        let networkMonitoringService = NetworkMonitoringService()
        let networkingService = NetworkingService(session: session, networkMonitoringService: networkMonitoringService)

        let pushTokenWebRepository = PushTokenWebRepository(networkService: networkingService)

        return .init(pushTokenWebRepository: pushTokenWebRepository)
    }

    static func configuredURLSession() -> URLSession {
       let configuration = URLSessionConfiguration.default
       configuration.timeoutIntervalForRequest = 60
       configuration.timeoutIntervalForResource = 120
       configuration.waitsForConnectivity = true
       configuration.httpMaximumConnectionsPerHost = 5
       configuration.requestCachePolicy = .returnCacheDataElseLoad
       configuration.urlCache = .shared
       return URLSession(configuration: configuration)
   }
}

extension DependencyContainer {
    struct WebRepositories {
        let pushTokenWebRepository: PushTokenWebRepository
    }

    struct DBRepositories {
#warning("тут будет Core data")
    }
}


extension EnvironmentValues {
    var container: DependencyContainer {
        get { self[DependencyContainer.self] }
        set { self[DependencyContainer.self] = newValue}
    }
}

extension DependencyContainer {
    static var preview: Self {
        .init()
    }
}

extension View {
    func inject(_ container: DependencyContainer) -> some View {
        return self
            .modifier(RootViewAppearance())
            .environment(\.container, container)
    }
}
