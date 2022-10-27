//
//  HolyQuranTestApp.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 24.10.2022.
//

import SwiftUI
import Firebase
import Combine


@main
struct HolyQuranTestApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @Environment(\.scenePhase) var scenePhase

    private let appEnvironment = AppEnvironment.bootstrap()

    // MARK: - body View

    var body: some Scene {
        WindowGroup {
            ContentView()
                .tabBarAppearance()
                .inject(appEnvironment.container)
                .preferredColorScheme(.light)
                .onAppear {
                    Task {
                        appDelegate.systemEventsHandler = appEnvironment.systemEventsHandler
                    }
                }
                .onOpenURL { url in
                    appDelegate.sceneOpenURLContexts(url: url)
                }
                .onChange(of: scenePhase) { newPhase in
                    appDelegate.handleLifeCycleApp(with: newPhase)
                }
        }
    }
}
