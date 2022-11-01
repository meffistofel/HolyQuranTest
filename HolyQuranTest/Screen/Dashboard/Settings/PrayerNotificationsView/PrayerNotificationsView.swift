//
//  PrayerNotificationsView.swift
//  HolyQuranTest
//
//  Created by Александр Ковалев on 29.10.2022.
//  
//

import SwiftUI
import Combine

// MARK: - PrayerNotificationsView


struct PrayerNotificationsView: View {

    // MARK: - Wrapped Properties

    @Environment(\.container) private var container: DependencyContainer
    @ObservedObject private var viewModel: PrayerNotificationsVM
    @State private var routingState: Routing = .init()
   

    // MARK: - Properties

    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: container.appState, \.routing.prayerNotifications)
    }

    // MARK: - Init

    init(viewModel: PrayerNotificationsVM) {
        self.viewModel = viewModel
    }

    // MARK: - body View
    
    var body: some View {
        VStack {
            ActionRow(menu: .prayerNotification, content: { Toggle("", isOn: $viewModel.prayerNotificationIsOn) })
            
            ForEach(viewModel.prayers) { prayer in
                ActionRow(menu: .prayer(prayer.title), isNeedDivider: (false, true), subContent: {
                    Text(prayer.time)
                        .customFont(.regular, size: 14)
                }, onTap: {
                    if viewModel.prayerNotificationIsOn {
                       
                        viewModel.selectedPrayer = prayer
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            container.appState[\.routing.prayerNotifications.state] = .prayerSound(prayer)
                        }
                       
                    }
                })
            }
            .disabled($viewModel.prayerNotificationIsOn)
           
            Spacer()
        }
       
        .padding()
        .navigationTitle("Prayer Notifications")
        .routing(routingBinding: routingBinding.state, with: [.prayerSound(viewModel.selectedPrayer)])
        .navigationBarTitleDisplayMode(.inline)
        .navigationBackButton(type: .darkArrow)
        .onReceive(routingUpdate) { self.routingState = $0 }
    }
}

// MARK: - ViewBuilder View

private extension PrayerNotificationsView {

}

// MARK: - Side Effects

private extension PrayerNotificationsView {

}

// MARK: - State Updates

private extension PrayerNotificationsView {

}

// MARK: - Routing

extension PrayerNotificationsView {
    struct Routing: Equatable {
        var state: NavigationState?
    }

    var routingUpdate: AnyPublisher<Routing, Never> {
        container.appState.updates(for: \.routing.prayerNotifications)
    }
}

// MARK: - Previews

#if DEBUG
struct PrayerNotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerNotificationsView(viewModel: .preview)
    }
}
#endif
