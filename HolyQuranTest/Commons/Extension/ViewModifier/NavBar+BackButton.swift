//
//  NavBar+BackButton.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 03.10.2022.
//

import SwiftUI

enum BackButtonType {
    case whiteArrow
    case darkArrow
    case text(String, Color)
    case textWithImage(String, Color)

    @ViewBuilder
    var backButton: some View {
        switch self {
        case .whiteArrow:
            Image("button_back_white")
        case .darkArrow:
            Image("button_back_dark")
        case let .text(text, color):
            CustomText(text: text, font: (.regular, 16), foregroundColor: color)
                .lineLimit(1)
        case let .textWithImage(text, color):
            HStack(spacing: 3) {
                Image("button_back_dark")

                CustomText(text: text, font: (.regular, 16), foregroundColor: color)
                    .lineLimit(1)
            }
        }
    }
}

// MARK: - NavigationBackButton

struct NavigationBackButton: ViewModifier {

    @Environment(\.presentationMode) var presentationMode

    let type: BackButtonType
    var action: EmptyClosure?

    func body(content: Content) -> some View {
        return content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        action?()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        type.backButton
                    }
                }
            }
    }
}

// MARK: - NavigationBackButton Modifier

extension View {
    func navigationBackButton(type: BackButtonType, action: EmptyClosure? = nil) -> some View {
        modifier(NavigationBackButton(type: type, action: action))
    }
}

