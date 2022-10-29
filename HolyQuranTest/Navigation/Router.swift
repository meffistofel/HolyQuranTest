//
//  TagNavigation.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 17.10.2022.
//

import SwiftUI

struct Router: ViewModifier {

    @Environment(\.container) private var container: DependencyContainer
    @Binding var routingBinding: NavigationState?

    let tags: [NavigationState]

    func body(content: Content) -> some View {
        content
            .background(navigationToSelectedList)
    }
}

private extension Router {

    @ViewBuilder
    var navigationToSelectedList: some View {
        ForEach(tags, id: \.self) { tag in
            TagNavigationLink(
                routingBinding: $routingBinding,
                tag: tag
            ) {
                content(tag: tag)
            } label: {
                EmptyView()
            }
        }
    }

    @ViewBuilder
    func content(tag: NavigationState) -> some View {
        switch tag {
        case .activity:
            ActivityView(viewModel: ActivityVM(appState: container.appState))
        case .setWeeklyGoal:
            SetWeeklyGoalView(viewModel: SetWeeklyGoalVM(appState: container.appState))
        case .none:
            Text("")
//            SignInView(viewModel: SignInVM(
//                loginService: container.loginService,
//                appState: container.appState,
//                googleLoginService: container.googleLoginService,
//                facebookLoginService: container.facebookLoginService
//            ))
        }
    }
}

extension View {
    func routing(routingBinding: Binding<NavigationState?>, with tags: [NavigationState]) -> some View {
        modifier(Router(routingBinding: routingBinding, tags: tags))
    }
}
