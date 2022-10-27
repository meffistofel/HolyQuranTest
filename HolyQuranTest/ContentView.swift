//
//  ContentView.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 26.10.2022.
//

import SwiftUI
import Combine

struct ContentView: View {

    // MARK: - Wrapped Properties

    @Environment(\.container) var container: DependencyContainer

    @State private var routingState: Routing = .init()
    @State private var isActive: Bool = false

    // MARK: - Properties

    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: container.appState, \.routing.contentView)
    }

    // MARK: - Init

    init() {
        setupAuthentication()
    }

    var body: some View {
        VStack {
            if routingState.isActive {
                if UserDefaults.isShowOnboarding || routingState.onBoardingSkip {
                    AppFlowView()
                        .inject(container)
                        .transition(.opacity)
                } else {
                    OnboardingView()
                        .transition(.opacity)
                }
            } else {
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                container.appState[\.routing.contentView.isActive] = true
                            }
                        }
                    }
            }
        }
        .onReceive(routingUpdate) { self.routingState = $0 }
    }
}

// MARK: - Routing

extension ContentView {
    struct Routing: Equatable {
        var isActive: Bool = false
        var onBoardingSkip: Bool = false
    }

    var routingUpdate: AnyPublisher<Routing, Never> {
        container.appState.updates(for: \.routing.contentView)
    }
}

extension ContentView {
    func setupAuthentication() {
//        FirebaseApp.configure()
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .inject(.defaultValue)
    }
}
#endif
