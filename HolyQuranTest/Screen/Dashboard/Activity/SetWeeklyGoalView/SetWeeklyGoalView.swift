//
//  SetWeeklyGoalView.swift
//  HolyQuranTest
//
//  Created by Александр Ковалев on 28.10.2022.
//  
//

import SwiftUI
import Combine

// MARK: - SetWeeklyGoalView

struct SetWeeklyGoalView: View {

    // MARK: - Wrapped Properties

    @Environment(\.container) private var container: DependencyContainer
    @ObservedObject private var viewModel: SetWeeklyGoalVM
    @State private var routingState: Routing = .init()

    // MARK: - Properties

    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: container.appState, \.routing.setWeeklyGoal)
    }

    // MARK: - Init

    init(viewModel: SetWeeklyGoalVM) {
        self.viewModel = viewModel
    }

    // MARK: - body View

    var body: some View {
        
        ScrollView {
            VStack(spacing: 0) {
                Text("Set your weekly goal")
                    .customFont(.bold, size: 20)
                    .padding(.top, 32)
                    .padding(.bottom, 40)
                
                questionnaire
                    .padding(.horizontal, 16)
            }
            
            .routing(routingBinding: routingBinding.state, with: [.none])
            .toolbar(.hidden)
        .onReceive(routingUpdate) { self.routingState = $0 }
        }
    }
}

// MARK: - ViewBuilder View

private extension SetWeeklyGoalView {
    
    @ViewBuilder
    var questionnaire: some View {
        VStack(alignment: .leading, spacing: 0) {
            WeeklyQuestionView(text: "How many days a week do you want to read quran?", spacing: 12) {
                Text("\(viewModel.daysPerWeek, specifier: "%.0f")")
                    .customFont(.semibold, size: 18)
                
                Slider(value: $viewModel.daysPerWeek, in: 0...7, step: 1)
                    .padding(.bottom, 32)
            }
            
            WeeklyQuestionView(text: "How many days a week do you want to read quran?") {
                WeeklyAnswerView(text: "30 minutes")
            }
                .padding(.bottom, 32)
            
            WeeklyQuestionView(text: "How many verses per week do you want to read?") {
                WeeklyAnswerView(text: "24 verse")
            }
            .padding(.bottom, 28)
            
            ActionRow(menu: .turnPushNotification, font: (.medium, 14), content: {
                Toggle("", isOn: $viewModel.turnPushNotification)
            })
            .padding(.bottom, 66)
            
            HStack(spacing: 13) {
                LargeButton(type: .cancel) {
                    container.appState[\.routing.activity.state] = nil
                }
                LargeButton(type: .done) {
                    container.appState[\.routing.activity.state] = nil
                }
            }
        }
    }
}

// MARK: - Side Effects

private extension SetWeeklyGoalView {

}

// MARK: - State Updates

private extension SetWeeklyGoalView {

}

// MARK: - Routing

extension SetWeeklyGoalView {
    struct Routing: Equatable {
        var state: NavigationState?
    }

    var routingUpdate: AnyPublisher<Routing, Never> {
        container.appState.updates(for: \.routing.setWeeklyGoal)
    }
}

// MARK: - Previews

#if DEBUG
struct SetWeeklyGoalView_Previews: PreviewProvider {
    static var previews: some View {
        SetWeeklyGoalView(viewModel: .preview)
    }
}
#endif
