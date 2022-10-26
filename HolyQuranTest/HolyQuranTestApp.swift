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

    // MARK: - Wrapped Properties

    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @Environment(\.scenePhase) var scenePhase

    // MARK: - Properties

    private let appEnvironment = AppEnvironment.bootstrap()

    // MARK: - Init

    init() {
        setupAuthentication()
    }

    // MARK: - body View

    var body: some Scene {
        WindowGroup {
            AppFlowView()
                .tabBarAppearance()
                .inject(appEnvironment.container)
                .environment(\.colorScheme, .light)
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

extension HolyQuranTestApp {
    func setupAuthentication() {
//        FirebaseApp.configure()
    }
}
