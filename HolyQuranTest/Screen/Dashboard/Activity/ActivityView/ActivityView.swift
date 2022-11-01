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
                SegmentedControlView(selectedIndex: $viewModel.activity, segments: [.weekly, .monthly], isNeedUnderLine: false)
                
                if viewModel.activity == 0 {
                    weekly
                } else {
                    monthly
                }
            }
            .padding(.horizontal, 16)
        }
        .fullScreenCover(isPresented: routingBinding.isPresented) {
            SetWeeklyGoalView(viewModel: SetWeeklyGoalVM(appState: container.appState))
        }
        .routing(routingBinding: routingBinding.state, with: [.none])
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


// MARK: - ViewBuilder View

private extension ActivityView {

    @ViewBuilder
    var weekly: some View {
        VStack(spacing: 8) {
            
           

            ForEach(0..<3) { index in
                if index == 0 {
                    BarChartView(dataPoints: viewModel.dataSetWeekly[index]) {
                        WeeklyCalendar(calendar: .current)
                    }
                } else {
                    let element = viewModel.dataSetWeekly[index].model
                    let width = setWidthElement(countElement: element.count, spacing: 39)
                    let spacing = setSpacing(count: element.count, differenct: width + 6)
                    
                    BarChartView(dataPoints: viewModel.dataSetWeekly[index]) {
                        HStack(spacing: spacing) {
                            ForEach(element) {
                                BarView(dataPoint: $0, width: width, isNeedText: true)
                            }
                        }
                    }
                }
            }
            
            LargeButton(
                type: .setGoals,
                buttonHorizontalMargins: 92,
                backgroundColor: .black,
                foregroundColor: .white
            ) {
                container.appState[\.routing.activity.isPresented] = true
            }
            .padding(.top, 24)
            .frame(height: 50)
        }
    }
    
    @ViewBuilder
    var monthly: some View {
        VStack {
            MultiDatePicker(anyDays: $viewModel.selectedMonthDate, includeDays: .allDays)
            
            ForEach(0..<2) { index in
                BarChartView(dataPoints: viewModel.dataSetMonthly[index]) {
                    HStack(spacing: 8) {
                        ForEach(viewModel.dataSetMonthly[index].model) {
                            BarView(dataPoint: $0, width: setWidthElement(countElement: viewModel.dataSetMonthly[index].model.count, spacing: 8), isNeedText: false)
                        }
                    }
                }
            }
        }
    }
    
    private func setWidthElement(countElement: Int, spacing: CGFloat) -> CGFloat {
        (UIScreen.main.bounds.width - 32) / CGFloat(countElement) - spacing - 1
    }
    
    private func setSpacing(count: Int, differenct: CGFloat) -> CGFloat {
        UIScreen.main.bounds.width / CGFloat(count) - differenct
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
        var isPresented: Bool = false
    }

    var routingUpdate: AnyPublisher<Routing, Never> {
        container.appState.updates(for: \.routing.activity)
    }
}

// MARK: - Previews

#if DEBUG
struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ActivityView(viewModel: .preview)
            ActivityView(viewModel: .preview)
                .previewDevice("iPhone SE (3rd generation)")
        }
    }
}
#endif
