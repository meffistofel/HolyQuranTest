//
//  PushNotificationsHandler.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 25.08.2022.
//

import UserNotifications

protocol PushNotificationsHandlerProtocol { }

class PushNotificationsHandler: NSObject, PushNotificationsHandlerProtocol {

    private let deepLinksHandler: DeepLinksHandler

    init(deepLinksHandler: DeepLinksHandler) {
        self.deepLinksHandler = deepLinksHandler
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
}

extension PushNotificationsHandler: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.banner, .sound]
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo
        handleNotification(userInfo: userInfo)
    }

    func handleNotification(userInfo: [AnyHashable: Any]) {
        guard let payload = userInfo["aps"] as? NotificationPayload,
            let code = payload["country"] as? String else {
            return
        }
        deepLinksHandler.open(deepLink: .newCase(someCode: code))
    }
}
