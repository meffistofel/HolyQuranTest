//
//  LargeButton.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 29.08.2022.
//

import SwiftUI

struct LargeButton: View {

    private let disabled: Bool
    private let buttonHorizontalMargins: CGFloat
    private let action: () -> Void
    private let type: LargeButtonType
    private let font: FontBook
    private let fontSize: CGFloat

    init(
        type: LargeButtonType,
        disabled: Bool = false,
        buttonHorizontalMargins: CGFloat = 0,
        font: FontBook = .bold,
        fontSize: CGFloat = 16,
        action: @escaping () -> Void
    ) {
        self.type = type
        self.disabled = disabled
        self.buttonHorizontalMargins = buttonHorizontalMargins
        self.font = font
        self.fontSize = fontSize
        self.action = action
    }

    var body: some View {
        HStack {
            Spacer(minLength: buttonHorizontalMargins)
            Button(action: action) {
                Text(type.title)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(
                LargeButtonStyle(
                    type: type,
                    isDisabled: disabled,
                    font: font,
                    fontSize: fontSize
                )
            )
            .disabled(disabled)
            Spacer(minLength: buttonHorizontalMargins)
        }
    }
}

struct LargeButtonStyle: ButtonStyle {

    let type: LargeButtonType
    let isDisabled: Bool
    let font: FontBook
    let fontSize: CGFloat

    func makeBody(configuration: Self.Configuration) -> some View {
        let currentForegroundColor = isDisabled || configuration.isPressed ? type.foregroundColor.opacity(0.3) : type.foregroundColor
        return configuration.label
            .padding()
            .foregroundColor(currentForegroundColor)
            .background(backgroundCustomColor(with: configuration))
            .cornerRadius(8)
            .overlay(type.isNeedBorder ? RoundedRectangle(cornerRadius: 8)
                .stroke(currentForegroundColor, lineWidth: 1)
            : nil)
            .customFont(font, size: fontSize)
    }

    @ViewBuilder
    private func backgroundCustomColor(with configuration: Self.Configuration) -> some View {
        if type.isNeedGradient {
            LinearGradient(colors: isDisabled ? [Color.startGradient.opacity(0.4)] : Color.gradient, startPoint: .leading, endPoint: .trailing)
        } else {
            isDisabled || configuration.isPressed ? type.backgroundColor.opacity(0.3) : type.backgroundColor
        }
    }
}

