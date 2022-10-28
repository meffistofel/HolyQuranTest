//
//  ActivityView.swift
//  HolyQuranTest
//
//  Created by Александр Ковалев on 28.10.2022.
//  
//

import SwiftUI
import Combine

// MARK: - ActivityView

struct ActivityView: View {

    // MARK: - Wrapped Properties

    @Environment(\.container) private var container: DependencyContainer
    @ObservedObject private var viewModel: ActivityVM
    @State private var routingState: Routing = .init()
    
    let dataSet = [
        DataSet.dublin,
        DataSet.milan,
        DataSet.london
    ]
    
    @State
    var selectedCity = 0
    

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
        VStack(spacing: 8) {
            SegmentedControlView(selectedIndex: $selectedCity, segments: [.weekly, .monthly], isNeedUnderLine: false)

            BarChartView(dataPoints: dataSet[0])
            
            BarChartView(dataPoints: dataSet[1])
            
            BarChartView(dataPoints: dataSet[2])
               
        }
        .padding(.horizontal, 16)
        .routing(routingBinding: routingBinding.state, with: [.none])
        .navigationBarTitleDisplayMode(.inline)
        .navigationBackButton(type: .darkArrow)
        .onReceive(routingUpdate) { self.routingState = $0 }
    }
}

// MARK: - ViewBuilder View

private extension ActivityView {

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
