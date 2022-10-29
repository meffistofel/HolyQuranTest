//
//  ContentView.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 24.10.2022.
//

import SwiftUI
import Introspect
import Combine

struct AppFlowView: View {
    
    @State var uiTabarController: UITabBarController?

    @Environment(\.container) private var container: DependencyContainer

    var body: some View {
        TabView {
            HomeView(viewModel: HomeVM(appState: container.appState))
                .tabItem { Label("Home", image: Constants.Image.iconHome) }

            QuranView(viewModel: QuranVM(appState: container.appState))
                .tabItem { Label("Quran", image: Constants.Image.iconQuran) }
            
            QuiblaView(viewModel: QuiblaVM(appState: container.appState))
                .tabItem { Label("Quibla", image: Constants.Image.iconQuibla) }
            
            DiscoverView(viewModel: DiscoverVM(appState: container.appState))
                .tabItem { Label("Idea", image: Constants.Image.iconIdea) }
            
            SettingsView(viewModel: SettingsVM(appState: container.appState))
                .tabItem { Label("Settings", image: Constants.Image.iconSettings) }
        }
        .introspectTabBarController { (UITabBarController) in
            uiTabarController = UITabBarController
        }
        .accentColor(.black)
        .onReceive(tabBarUpdate) { uiTabarController?.tabBar.isHidden = $0 }
    }
}

// MARK: - Tab Bar update

extension AppFlowView {

    var tabBarUpdate: AnyPublisher<Bool, Never> {
        container.appState.updates(for: \.system.tabBarIsHidden)
    }
}



struct AppFlowView_Previews: PreviewProvider {
    static var previews: some View {
        AppFlowView()
    }
}
