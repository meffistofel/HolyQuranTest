//
//  OnboardingView.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 26.10.2022.
//  
//

import SwiftUI
import Combine

// MARK: - OnboardingView

struct OnboardingView: View {

    // MARK: - Wrapped Properties

    @Environment(\.container) private var container: DependencyContainer
    @ObservedObject private var viewModel: OnboardingVM
    @State private var routingState: Routing = .init()

    // MARK: - Properties

    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: container.appState, \.routing.onboarding)
    }

    // MARK: - Init

    init(viewModel: OnboardingVM) {
        self.viewModel = viewModel
    }

    // MARK: - body View

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .routing(routingBinding: routingBinding.state, with: [.none])
            .navigationBarTitleDisplayMode(.inline)
            .onReceive(routingUpdate) { self.routingState = $0 }
    }
}

// MARK: - ViewBuilder View

private extension OnboardingView {

}

// MARK: - Side Effects

private extension OnboardingView {

}

// MARK: - State Updates

private extension OnboardingView {

}

// MARK: - Routing

extension OnboardingView {
    struct Routing: Equatable {
        var state: NavigationState?
    }

    var routingUpdate: AnyPublisher<Routing, Never> {
        container.appState.updates(for: \.routing.onboarding)
    }
}

// MARK: - Previews

#if DEBUG
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(viewModel: .preview)
    }
}
#endif
