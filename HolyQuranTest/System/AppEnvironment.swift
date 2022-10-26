//
//  AppEnvironment.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 25.08.2022.
//

import UIKit


struct AppEnvironment {
    let container: DependencyContainer
    let systemEventsHandler: SystemEventsHandler
}

extension AppEnvironment {
    static func bootstrap() -> AppEnvironment {
        let dependencyContainer = DependencyContainer()
        let deepLinksHandler = DeepLinksHandler(container: dependencyContainer)
        let pushNotificationHandler = PushNotificationsHandler(deepLinksHandler: deepLinksHandler)
        let userPermissionsService = UserPermissionsService(appState: dependencyContainer.appState) {
            URL(string: UIApplication.openSettingsURLString).flatMap {
                UIApplication.shared.open($0, options: [:], completionHandler: nil)
            }
        }
        let systemEventsHandler = SystemEventsHandler(
            container: dependencyContainer,
            deepLinksHandler: deepLinksHandler,
            pushNotificationsHandler: pushNotificationHandler,
            pushTokenWebRepository: dependencyContainer.webRepositories.pushTokenWebRepository,
            userPermissionsService: userPermissionsService
        )

        return AppEnvironment(container: dependencyContainer, systemEventsHandler: systemEventsHandler)
    }
}
