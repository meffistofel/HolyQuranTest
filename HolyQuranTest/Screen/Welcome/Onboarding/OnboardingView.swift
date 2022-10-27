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
    @State private var routingState: Routing = .init()
    @State private var index: Int = 0

    let pages: [PageViewData] = [
        PageViewData(imageNamed: "1", text: "A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring"),
        PageViewData(imageNamed: "2", text: "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated"),
        PageViewData(imageNamed: "3", text: "A small river named Duden flows by their place and supplies it with the necessary regelialia.")
    ]

    // MARK: - Properties

    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: container.appState, \.routing.onboarding)
    }

    // MARK: - body View

    var body: some View {
        NavigationView {
            SwiperView(pages: self.pages, index: self.$index)
                .navigationAppearance(type: .transparent)
                .setCustomToolBarItem(placement: .navigationBarTrailing) { skip }
                .edgesIgnoringSafeArea(.all)
                .routing(routingBinding: routingBinding.state, with: [.none])
                .navigationBarTitleDisplayMode(.inline)
                .onReceive(routingUpdate) { self.routingState = $0 }
                .onAppear {  UserDefaults.isShowOnboarding = true }
        }
        .navigationViewStyle(.stack)
    }
}

// MARK: - ViewBuilder View

private extension OnboardingView {

    @ViewBuilder
    var skip: some View {
        Button {
            withAnimation {
                container.appState[\.routing.contentView.onBoardingSkip] = true
            }
        } label: {
            Text("Skip")
                .customFont(.semibold, size: 16)
                .foregroundColor(.black)
        }
    }
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
        NavigationView {
            OnboardingView()
                .inject(.defaultValue)
        }
    }
}
#endif
