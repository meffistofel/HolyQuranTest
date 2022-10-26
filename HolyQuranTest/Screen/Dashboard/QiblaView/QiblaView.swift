//
//  QuiblaView.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 26.10.2022.
//  
//

import SwiftUI
import Combine

// MARK: - QuiblaView

struct QuiblaView: View {

    // MARK: - Wrapped Properties

    @Environment(\.container) private var container: DependencyContainer
    @ObservedObject private var viewModel: QuiblaVM
    @ObservedObject var compassHeading = CompassHeading()
    @State private var routingState: Routing = .init()
    @State private var searchText: String = ""

    // MARK: - Properties

    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: container.appState, \.routing.quibla)
    }

    // MARK: - Init

    init(viewModel: QuiblaVM) {
        self.viewModel = viewModel
    }

    // MARK: - body View

    var body: some View {
        GeometryReader { geo in
            VStack {
                SearchBar(text: $searchText)
                    .padding(.bottom, 44)
                SegmentedControlView(selectedIndex: $viewModel.selectedIndex, segments: [.map, .compass])
                    .padding(.horizontal, 9)
                //            Spacer()

                QiblaCompass(degrees: 34.333, compassDegrees: compassHeading.degrees)
                    .frame(width: geo.size.width - 64, height: geo.size.width - 64)
                    .padding(.top, 90)

                Spacer()

                HStack {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("QUibla from the North")
                        Text("Distance")
                    }
                    .foregroundColor(.gray)
                    .customFont(.medium, size: 16)

                    Spacer()

                    VStack(alignment: .trailing, spacing: 15 ) {
                        Text("156. 6")
                        Text("3469.6 kms")
                    }
                    .customFont(.semibold, size: 16)
                }
            }
        }
        .padding([.leading, .trailing, .top])
        .padding(.bottom, 33)
        .routing(routingBinding: routingBinding.state, with: [.none])
        .toolbar(.hidden)
        .onReceive(routingUpdate) { self.routingState = $0 }
    }
}

// MARK: - ViewBuilder View

private extension QuiblaView {

}

// MARK: - Side Effects

private extension QuiblaView {

}

// MARK: - State Updates

private extension QuiblaView {

}

// MARK: - Routing

extension QuiblaView {
    struct Routing: Equatable {
        var state: NavigationState?
    }

    var routingUpdate: AnyPublisher<Routing, Never> {
        container.appState.updates(for: \.routing.quibla)
    }
}

// MARK: - Previews

#if DEBUG
struct QuiblaView_Previews: PreviewProvider {
    static var previews: some View {
        QuiblaView(viewModel: .preview)
    }
}
#endif
