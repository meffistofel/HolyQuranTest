//
//  ActivityView.swift
//  HolyQuranTest
//
//  Created by Александр Ковалев on 28.10.2022.
//  
//

import SwiftUI
import Combine
import Introspect

// MARK: - ActivityView

struct ActivityView: View {

    // MARK: - Wrapped Properties

    @Environment(\.container) private var container: DependencyContainer
    @ObservedObject private var viewModel: ActivityVM
    @State private var routingState: Routing = .init()
        
    // MARK: - Properties

    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: container.appState, \.routing.activity)
    }

    // MARK: - Init

    init(viewModel: ActivityVM) {
        self.viewModel = viewModel
    }

    // MARK: - body View

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
            if viewModel.activityState == .weekly {
                weekly
            } else {
                monthly
            }
        }
        .padding(.horizontal, 16)
        .routing(routingBinding: routingBinding.state, with: [.setWeeklyGoal])
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("You activity")
        .navigationBackButton(type: .darkArrow) {
            container.appState[\.system.tabBarIsHidden] = false
        }
        .onReceive(routingUpdate) { self.routingState = $0 }
        .introspectTabBarController { UITabBarController in
            container.appState[\.system.tabBarIsHidden] = true
        }
    }
}
}

// MARK: - ViewBuilder View

private extension ActivityView {

    @ViewBuilder
    var weekly: some View {
        VStack(spacing: 8) {
            SegmentedControlView(selectedIndex: $viewModel.selectedCity, segments: [.weekly, .monthly], isNeedUnderLine: false)

            ForEach(0..<3) { index in
                BarChartView(dataPoints: viewModel.dataSet[index])
            }
            
            LargeButton(type: .setGoals, buttonHorizontalMargins: 92) {
                container.appState[\.routing.activity.state] = .setWeeklyGoal
            }
            .padding(.top, 24)
            .frame(height: 50)
        }
    }
    
    @ViewBuilder
    var monthly: some View {
        Text("")
    }
}

// MARK: - Side Effects

private extension ActivityView {

}

// MARK: - State Updates

private extension ActivityView {

}

// MARK: - Routing

extension ActivityView {
    struct Routing: Equatable {
        var state: NavigationState?
    }

    var routingUpdate: AnyPublisher<Routing, Never> {
        container.appState.updates(for: \.routing.activity)
    }
}

// MARK: - Previews

#if DEBUG
struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView(viewModel: .preview)
    }
}
#endif
