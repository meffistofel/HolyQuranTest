//
//  DiscoverView.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 26.10.2022.
//  
//

import SwiftUI
import Combine

// MARK: - DiscoverView

struct DiscoverView: View {

    // MARK: - Wrapped Properties

    @Environment(\.container) private var container: DependencyContainer
    @ObservedObject private var viewModel: DiscoverVM
    @State private var routingState: Routing = .init()

    // MARK: - Properties

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible())
    ]

    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: container.appState, \.routing.discover)
    }

    // MARK: - Init

    init(viewModel: DiscoverVM) {
        self.viewModel = viewModel
    }

    // MARK: - body View

    var body: some View {
        GeometryReader { geo in
            VStack {
                categories(geo: geo)
                    .padding(.bottom, 40)

                articles(geo: geo)
                    .padding(.horizontal, 16)
                Spacer()

            }
            .padding(.top, 16)
            .routing(routingBinding: routingBinding.state, with: [.none])
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Discover")
            .onReceive(routingUpdate) { self.routingState = $0 }
        }
    }
}

// MARK: - ViewBuilder View

private extension DiscoverView {

    @ViewBuilder
    func categories(geo: GeometryProxy) -> some View {
        VStack {
            ContentWithSpacer(contentAlignment: .leading) {
                Text("Categories")
                    .customFont(.semibold, size: 18)
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 28)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 32) {
                    ForEach(1..<10, id: \.self) { index in
                        VStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray)
                                .frame(width: geo.size.width / 4 - 36 , height: geo.size.width / 4 - 36)
                            Text("Islamic events")
                                .customFont(.medium, size: 14)
                                .frame(width: geo.size.width / 4 - 36)
                                .multilineTextAlignment(.center)
                                .lineLimit(3)
                        }

                    }
                }
                .padding(.horizontal, 24)
            }
        }
    }

    @ViewBuilder
    func articles(geo: GeometryProxy) -> some View {
        ContentWithSpacer(contentAlignment: .leading) {
            Text("Articles")
                .customFont(.semibold, size: 18)
        }

        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(1..<7) { item in
                    VStack(alignment: .leading, spacing: 16) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray)
                            .frame(height: 140)
                        Text("Introduction")
                            .customFont(.medium, size: 14)
                    }
                }
            }
        }
    }
}

// MARK: - Side Effects

private extension DiscoverView { }

// MARK: - State Updates

private extension DiscoverView { }

// MARK: - Routing

extension DiscoverView {
    struct Routing: Equatable {
        var state: NavigationState?
    }

    var routingUpdate: AnyPublisher<Routing, Never> {
        container.appState.updates(for: \.routing.discover)
    }
}

// MARK: - Previews

#if DEBUG
struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView(viewModel: .preview)
    }
}
#endif
