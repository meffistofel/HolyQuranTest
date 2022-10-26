//
//  QuranView.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 25.10.2022.
//  
//

import SwiftUI
import Combine

// MARK: - QuranView

struct QuranView: View {

    

    let titles: [String] =
        ["First",
         "Second",
         "Third",
        ]

    // MARK: - Wrapped Properties

    @Environment(\.container) private var container: DependencyContainer
    @ObservedObject private var viewModel: QuranVM
    @State private var routingState: Routing = .init()

    // MARK: - Properties

    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: container.appState, \.routing.quran)
    }

    // MARK: - Init

    init(viewModel: QuranVM) {
        self.viewModel = viewModel
    }

    // MARK: - body View

    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 12) {
                ForEach(LastPrayerAction.allCases, id: \.self) { type in
                    ContinueRow(type: type)
                        .frame(maxWidth: .infinity)
                }
                }
                SegmentedControlView(selectedIndex: $viewModel.selectedIndex, segments: [.surah, .juz, .bookmarks])


                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 16) {
                        ForEach(1..<10) { index in
                            PrayerRow()
                        }
                    }
                    .padding(.top, 10)
                }

            }
            .padding([.leading, .trailing, .top], 16)
            .routing(routingBinding: routingBinding.state, with: [.none])
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Quran")
            .setCustomToolBarItem(placement: .navigationBarLeading) { searchButton }
            .setCustomToolBarItem(placement: .navigationBarTrailing) { settingsButton }
            .onReceive(routingUpdate) { self.routingState = $0 }
        }
        .navigationViewStyle(.stack)
    }
}

// MARK: - ViewBuilder View

private extension QuranView {

    @ViewBuilder
    var searchButton: some View {
        Button {
            Log.debug("Search did tap")
        } label: {
            Image(Constants.Image.iconSearch)
        }
    }

    @ViewBuilder
    var settingsButton: some View {
        Button {
            Log.debug("Settings did tap")
        } label: {
            Image(Constants.Image.iconQuranSettings)
        }
    }
}

// MARK: - Side Effects

private extension QuranView {

}

// MARK: - State Updates

private extension QuranView {

}

// MARK: - Routing

extension QuranView {
    struct Routing: Equatable {
        var state: NavigationState?
    }

    var routingUpdate: AnyPublisher<Routing, Never> {
        container.appState.updates(for: \.routing.quran)
    }
}

// MARK: - Previews

#if DEBUG
struct QuranView_Previews: PreviewProvider {
    static var previews: some View {
        QuranView(viewModel: .preview)
    }
}
#endif
