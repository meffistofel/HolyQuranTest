//
//  RootViewAppearance.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 25.08.2022.
//

import Combine
import SwiftUI

// MARK: - RootViewAppearance

struct RootViewAppearance: ViewModifier {

    @Environment(\.container) private var container: DependencyContainer
    @State private var isActive: Bool = false

    func body(content: Content) -> some View {
        content
            .ignoresSafeArea(.keyboard)
            .navigationAppearance(type: .opaque)
            .onReceive(stateUpdate) { self.isActive = $0 }
//            .blur(radius: isActive ? 0 : 10)
    }

    private var stateUpdate: AnyPublisher<Bool, Never> {
        container.appState.updates(for: \.system.isActive)
    }
}
