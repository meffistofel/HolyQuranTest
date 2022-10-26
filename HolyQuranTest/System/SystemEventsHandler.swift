//
//  SystemEventsHandler.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 25.08.2022.
//

import Combine
import UIKit

protocol SystemEventsHandlerProtocol {
    func sceneOpenURLContexts(_ url: URL)
    func sceneDidBecomeActive()
    func sceneWillResignActive()
    func handlePushRegistration(result: Result<Data, Error>) async
    func appDidReceiveRemoteNotification(payload: NotificationPayload) -> UIBackgroundFetchResult
}

struct SystemEventsHandler: SystemEventsHandlerProtocol {

    let container: DependencyContainer
    let deepLinksHandler: DeepLinksHandlerProtocol
    let pushNotificationsHandler: PushNotificationsHandlerProtocol
    let pushTokenWebRepository: PushTokenWebRepositoryProtocol
    let userPermissionsService: UserPermissionsServiceProtocol

    private var cancelBag = CancelBag()

    init(
        container: DependencyContainer,
        deepLinksHandler: DeepLinksHandlerProtocol,
        pushNotificationsHandler: PushNotificationsHandlerProtocol,
        pushTokenWebRepository: PushTokenWebRepositoryProtocol,
        userPermissionsService: UserPermissionsServiceProtocol
    ) {
        self.container = container
        self.deepLinksHandler = deepLinksHandler
        self.pushNotificationsHandler = pushNotificationsHandler
        self.pushTokenWebRepository = pushTokenWebRepository
        self.userPermissionsService = userPermissionsService

        installKeyboardHeightObserver()
        installPushNotificationsSubscriberOnLaunch()
    }

    func sceneDidBecomeActive() {
        container.appState[\.system.isActive] = true
        userPermissionsService.resolveStatus(for: .pushNotifications)
    }

    func sceneWillResignActive() {
        container.appState[\.system.isActive] = false
    }

    func sceneOpenURLContexts(_ url: URL) {
        handle(url: url)
    }

    func handlePushRegistration(result: Result<Data, Error>) async {
        if let pushToken = try? result.get() {
            do {
                try await pushTokenWebRepository.register(devicePushToken: pushToken)
            } catch let error {
                Log.error(error)
            }
        }
    }

    func appDidReceiveRemoteNotification(
        payload: NotificationPayload
    ) -> UIBackgroundFetchResult {
        return .newData
    }

    private func handle(url: URL) {
        guard let deepLink = DeepLink(url: url) else {
            return
        }

        deepLinksHandler.open(deepLink: deepLink)
    }

    private func installKeyboardHeightObserver() {
        let appState = container.appState
        NotificationCenter.default.keyboardHeightPublisher
            .sink { [appState] height in
                print(height)
                appState[\.system.keyboardHeight] = height
            }
            .store(in: cancelBag)
    }

    private func installPushNotificationsSubscriberOnLaunch() {
        weak var permissions = userPermissionsService
        container.appState
            .updates(for: AppState.permissionKeyPath(for: .pushNotifications))
            .first(where: { $0 != .unknown })
            .sink { status in
                if status == .granted {
                    // If the permission was granted on previous launch
                    // requesting the push token again:
                    permissions?.request(permission: .pushNotifications)
                }
            }
            .store(in: cancelBag)
    }
}


// MARK: - Notifications

private extension NotificationCenter {
    var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
        let willShow = publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        let willHide = publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        return Publishers.Merge(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

private extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?
            .cgRectValue.height ?? 0
    }
}
