//
//  HomeView.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 25.10.2022.
//  
//

import SwiftUI
import Combine

// MARK: - HomeView

struct HomeView: View {

    // MARK: - Wrapped Properties

    @Environment(\.container) private var container: DependencyContainer
    @ObservedObject private var viewModel: HomeVM

    @State private var routingState: Routing = .init()

    @State var isTruncated: Bool = false
    @State var forceFullText: Bool = false

    @State var progress = 0.0
    @State private var isLess = true

    // MARK: - Properties

    private let string = "And indeed, I fear the successors after me, and my wife has been barren, so give me from Yourself an heir. Who will inherit me1 and inherit from the family of Jacob. And indeed, I fear the successors1 after me, and my wife has been barren, so give me from Yourself an heir Who will inherit me1 and inherit from t inherit me1 and inherit from tninherit me1 and inherit from t"

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]


    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: container.appState, \.routing.home)
    }

    // MARK: - Init

    init(viewModel: HomeVM) {
        self.viewModel = viewModel
    }

    // MARK: - body View

    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ScrollView(isLess ? [] : .vertical) {
                    VStack(spacing: 0) {
                        VStack(alignment: .leading, spacing: 0) {
                            header
                            Spacer(minLength: 0)
                            weeklyActivity
                        }

                        activityRings
                        .padding(.bottom, 32)

                        Spacer()
                        prayers
                    }
                    .frame(minHeight: 0, maxHeight: .greatestFiniteMagnitude)
                    .padding([.leading, .trailing, .top], 16)

                }
                .onAppear { progress = 0.56 }
                .frame(width: geo.size.width)
                .routing(routingBinding: routingBinding.state, with: [.activity])
                .setCustomToolBarItem(placement: .principal) { Image(Constants.Image.logo) }
                .navigationBarTitleDisplayMode(.inline)
                .onReceive(routingUpdate) { self.routingState = $0 }
            }
        }
        .navigationViewStyle(.stack)
    }
}


// MARK: - ViewBuilder View

private extension HomeView {

    @ViewBuilder
    var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Verse of the day")
                    .font(.system(size: 18, weight: .medium))
                Spacer()
                Text("13:5")
                    .font(.system(size: 18, weight: .medium))
                    .underline()
            }

            TruncableText(text: Text(string)) { isTruncated = $0 }

            if isTruncated && !forceFullText || !isLess {
                Button {
                    withAnimation {
                        isLess.toggle()
                    }
                } label: {
                    Image(systemName: "hand.tap")
                }
            }
        }
    }

    @ViewBuilder
    var weeklyActivity: some View {
        HStack {
            Button {
                container.appState[\.routing.home.state] = .activity
            } label: {
                Label("Your weekly activity", systemImage: "arrow.forward")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.black)
                    .labelStyle(AdaptiveLabelStyle(iconAlignment: .trailing))
                    .padding(.vertical, 30)
                Spacer()
            }
        }
    }

    @ViewBuilder
    var activityRings: some View {
        HStack(spacing: 32) {
            ForEach(1..<4, id: \.self) { number in
                VStack(spacing: 0) {
                    CircularProgressView(progress: progress * 0.4 * Double(number))
                        .frame(width: 70, height: 70)
                        .overlay(Text("120"))
                        .font(.system(size: 18, weight: .semibold))
                        .padding(.bottom, 8)
                    Text("Verse")
                }
            }
        }
    }

    @ViewBuilder
    var prayers: some View {
        HStack {
            Text("Next Prayer")
                .font(.system(size: 14, weight: .medium))
            Spacer()
        }
        .padding(.bottom, 8 )

        HStack {
            Text("05h 48m 55s until Dhur")
                .font(.system(size: 18, weight: .semibold))
            Spacer()
        }
        .padding(.bottom, 8)

        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(1..<7) { item in
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Label("Fajr", systemImage: "bell.fill")
                            .labelStyle(AdaptiveLabelStyle())
                        Text("04:19 am")
                    }
                    .foregroundColor(item == 1 ? .white : .black)
                    .padding(.leading, 8)

                    Spacer()
                }
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 10)
                    .fill(item == 1 ?.gray.opacity(0.7) : .clear, strokeBorder: .gray.opacity(0.7))
                )

            }
        }
        .padding(.bottom, 12)

        HStack {
            Label("Location", systemImage: "location.circle.fill")
            Text("Lviv, Ukraine")
            Spacer()
        }
        .padding(.bottom, 16)
        .foregroundColor(.gray)
        .font(.system(size: 14, weight: .regular))
    }
}

// MARK: - Side Effects

private extension HomeView { }

// MARK: - State Updates

private extension HomeView { }

// MARK: - Routing

extension HomeView {
    struct Routing: Equatable {
        var state: NavigationState?
    }

    var routingUpdate: AnyPublisher<Routing, Never> {
        container.appState.updates(for: \.routing.home)
    }
}

// MARK: - Previews

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: .preview)
    }
}
#endif
