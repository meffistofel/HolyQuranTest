//
//  PrayerSoundView.swift
//  HolyQuranTest
//
//  Created by Александр Ковалев on 30.10.2022.
//  
//

import SwiftUI
import Combine

// MARK: - PrayerSoundView

struct PrayerSoundView: View {

    // MARK: - Wrapped Properties

    @Environment(\.container) private var container: DependencyContainer
    @ObservedObject private var viewModel: PrayerSoundVM
    @State private var routingState: Routing = .init()

    // MARK: - Properties

    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: container.appState, \.routing.prayerSound)
    }

    // MARK: - Init

    init(viewModel: PrayerSoundVM) {
        self.viewModel = viewModel
    }

    // MARK: - body View
    
    var body: some View {
        VStack(spacing: 16) {
            soundList
            ActionRow(menu: .preNotification, isNeedDivider: (false, true), content: {
                Toggle("", isOn: $viewModel.preNotificationIsOn)
            })
            
            if viewModel.preNotificationIsOn {
                Stepper("\(viewModel.minutes) minutes", value: $viewModel.minutes, in: 0...60, step: 5)
                Divider()
            }
            Spacer()
        }
        .padding([.top, .horizontal], 24)
        .routing(routingBinding: routingBinding.state, with: [.none])
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("\(viewModel.prayer.title)")
        .navigationBackButton(type: .darkArrow)
        .onReceive(routingUpdate) { self.routingState = $0 }
    }
    
    private func isCurrentSound(with sound: PrayerSound) -> Bool {
        viewModel.prayer.prayerSound == sound
    }
}

// MARK: - ViewBuilder View

private extension PrayerSoundView {

    @ViewBuilder
    var soundList: some View {
        ForEach(PrayerSound.allCases, id: \.self) { sound in
            LargeButton(
                type: .prayerSound,
                backgroundColor: isCurrentSound(with: sound) ? .black : .clear ,
                cornerRadius: 16
            ) {
                ContentWithSpacer(contentAlignment: .leading) {
                    Label {
                        Text(sound.text)
                    } icon: {
                        Image(sound.image)
                            .renderingMode(.template)
                            .frame(width: 29, alignment: .center)
                    }
                    .foregroundColor(viewModel.prayer.prayerSound == sound ? .white : .black)
                    .labelStyle(AdaptiveLabelStyle(iconAlignment: .leading, spacing: 12))
                    .padding(.leading, 8)
                }
            } action: {
                withAnimation {
                    viewModel.prayer.prayerSound = sound
                }
            }
        }
    }
}

// MARK: - Side Effects

private extension PrayerSoundView {

}

// MARK: - State Updates

private extension PrayerSoundView {

}

// MARK: - Routing

extension PrayerSoundView {
    struct Routing: Equatable {
        var state: NavigationState?
    }

    var routingUpdate: AnyPublisher<Routing, Never> {
        container.appState.updates(for: \.routing.prayerSound)
    }
}

// MARK: - Previews

#if DEBUG
struct PrayerSoundView_Previews: PreviewProvider {
    static var previews: some View {
        PrayerSoundView(viewModel: .preview)
    }
}
#endif
