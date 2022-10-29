//
//  SettingsView.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 26.10.2022.
//  
//

import SwiftUI
import Combine

// MARK: - SettingsView

struct SettingsView: View {

    // MARK: - Wrapped Properties

    @Environment(\.container) private var container: DependencyContainer
    @ObservedObject private var viewModel: SettingsVM
    @State private var routingState: Routing = .init()

    // MARK: - Properties

    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: container.appState, \.routing.settings)
    }

    // MARK: - Init

    init(viewModel: SettingsVM) {
        self.viewModel = viewModel
    }

    // MARK: - body View

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ContentWithSpacer(contentAlignment: .leading) {
                    Label("Settings", image: "icon_settings")
                        .customFont(.semibold, size: 24)
                }
                .padding([.horizontal, .top], 16)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        appSettings
                            .padding(.bottom, 43)
                        prayerTimesSettings
                            .padding(.bottom, 40)
                        pushNotifications
                            .padding(.bottom, 40)
                        support
                            .padding(.bottom, 40)

                        LargeButton(type: .logOut, cornerRadius: 8) {
                            Log.debug("Log Out did Tap")
                        }
                        .addShadowToRectangle(color: .gray.opacity(0.5), radius: 8, cornerRadius: 8)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 24)
                    .padding(.bottom, 16)
                }
//
            }
            .toolbar(.hidden)
            .routing(routingBinding: routingBinding.state, with: [.none])
            .onReceive(routingUpdate) { self.routingState = $0 }
        }
        .navigationViewStyle(.stack)
    }
}

// MARK: - ViewBuilder View

private extension SettingsView {

    @ViewBuilder
    var appSettings: some View {
        VStack(spacing: 0) {
            ContentWithSpacer(contentAlignment: .leading) {
                Text("APP SETTINGS")
                    .customFont(.medium, size: 16)
                    .foregroundColor(.gray)
            }
            ActionRow(menu: .mode, onTap: { })
            ActionRow(menu: .colorTheme, padding: ([.top], 24), onTap: { })
        }
    }

    @ViewBuilder
    var prayerTimesSettings: some View {
        VStack(spacing: 0) {
            ContentWithSpacer(contentAlignment: .leading) {
                Text("PRAYER TIMES SETTINGS")
                    .customFont(.medium, size: 16)
                    .foregroundColor(.gray)
            }
            ActionRow(menu: .prayerNotification, onTap: { })
            ActionRow(menu: .autoLocation, padding: ([.top], 28), content: { Toggle("", isOn: $viewModel.autoLocation) })
                .padding(.bottom, 24)

            ActionRow(menu: .address, isNeedDivider: (true, true), padding: ([.top, .bottom], 10), onTap: { })
                .padding(.bottom, 8)

            ActionRow(menu: .hourFormat, content: { Toggle("", isOn: $viewModel.hourFormat) })
            ActionRow(menu: .calculationMethod, onTap: { })
                .padding(.top, 9)
        }
    }

    @ViewBuilder
    var pushNotifications: some View {
        VStack(spacing: 0) {
            ContentWithSpacer(contentAlignment: .leading) {
                Text("PUSH NOTIFICATIONS")
                    .customFont(.medium, size: 16)
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 4)
            ActionRow(menu: .dayVerse, content: { Toggle("", isOn: $viewModel.dayVerse) })
                .padding(.bottom, 8)
            ActionRow(menu: .achievements, content: { Toggle("", isOn: $viewModel.achievements) })
        }
    }

    @ViewBuilder
    var support: some View {
        VStack(spacing: 0) {
            ContentWithSpacer(contentAlignment: .leading) {
                Text("SUPPORT THE HOLY QURAN")
                    .customFont(.medium, size: 16)
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 4)
            ActionRow(menu: .zakat, onTap: { })

        }
    }
}

// MARK: - Side Effects

private extension SettingsView {

}

// MARK: - State Updates

private extension SettingsView {

}

// MARK: - Routing

extension SettingsView {
    struct Routing: Equatable {
        var state: NavigationState?
    }

    var routingUpdate: AnyPublisher<Routing, Never> {
        container.appState.updates(for: \.routing.settings)
    }
}

// MARK: - Previews

#if DEBUG
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: .preview)
    }
}
#endif
