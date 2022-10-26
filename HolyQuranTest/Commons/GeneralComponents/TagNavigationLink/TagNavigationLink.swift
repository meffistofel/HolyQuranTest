//
//  TagNavigationLink.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 12.10.2022.
//

import SwiftUI

struct TagNavigationLink<Destination: View, Label: View> : View {

    @Environment(\.container) private var container: DependencyContainer
    @Binding var routingBinding: NavigationState?

    let destination: Destination
    let label: Label
    let tag: NavigationState

    init(
        routingBinding: Binding<NavigationState?>,
        tag: NavigationState,
        @ViewBuilder destination: () -> Destination,
        @ViewBuilder label: () -> Label
    ) {
        self._routingBinding = routingBinding
        self.destination = destination()
        self.label = label()
        self.tag = tag
    }

    var body: some View {
        NavigationLink(
            tag: tag,
            selection: $routingBinding
        ) {
            destination
        } label: {
            label
        }
    }
}
