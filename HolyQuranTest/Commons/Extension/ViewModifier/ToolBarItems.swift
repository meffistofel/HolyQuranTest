//
//  ToolBarItems.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 22.10.2022.
//

import SwiftUI

// MARK: - NavigationBackButton

struct CustomToolBarItem<Contents: View>: ViewModifier {

    let toolbarContent: Contents
    let placement: ToolbarItemPlacement

    init(placement: ToolbarItemPlacement, @ViewBuilder toolbarContent: () -> Contents) {
        self.toolbarContent = toolbarContent()
        self.placement = placement
    }

    func body(content: Content) -> some View {
        return content
            .toolbar {
                ToolbarItem(placement: placement) {
                    toolbarContent
                }
            }
    }
}

// MARK: - NavigationBackButton Modifier

extension View {
    func setCustomToolBarItem<Contents: View>(placement: ToolbarItemPlacement, @ViewBuilder toolbarContent: () -> Contents) -> some View {
        modifier(CustomToolBarItem(placement: placement, toolbarContent: toolbarContent))
    }
}
