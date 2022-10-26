//
//  AppDelegate.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 25.08.2022.
//

import UIKit
import SwiftUI

typealias NotificationPayload = [AnyHashable: Any]
typealias FetchCompletion = (UIBackgroundFetchResult) -> Void

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var systemEventsHandler: SystemEventsHandlerProtocol?

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Task {
            await systemEventsHandler?.handlePushRegistration(result: .success(deviceToken))
        }
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        Task {
            await systemEventsHandler?.handlePushRegistration(result: .failure(error))
        }
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
        let backgroundResult = systemEventsHandler?.appDidReceiveRemoteNotification(payload: userInfo) ?? .failed
        return UIBackgroundFetchResult(rawValue: backgroundResult.rawValue) ?? .failed
    }

    func handleLifeCycleApp(with phase: ScenePhase) {
        Log.debug(phase)

        if phase == .active {
            systemEventsHandler?.sceneDidBecomeActive()
        } else if phase == .inactive {
            systemEventsHandler?.sceneWillResignActive()
        }
    }

    func sceneOpenURLContexts(url: URL) {
        systemEventsHandler?.sceneOpenURLContexts(url)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }
}
