//
//  LargeButton.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 29.08.2022.
//

import SwiftUI

struct LargeButton<Content: View>: View {

    private let disabled: Bool
    private let buttonHorizontalMargins: CGFloat
    private let action: () -> Void
    private let type: LargeButtonType
    private let font: FontBook
    private let fontSize: CGFloat
    private let backgroundColor: Color
    private let foregroundColor: Color
    private let cornerRadius: CGFloat
    private let content: Content

    init(
        type: LargeButtonType,
        disabled: Bool = false,
        buttonHorizontalMargins: CGFloat = 0,
        font: FontBook = .bold,
        fontSize: CGFloat = 16,
        backgroundColor: Color = .clear,
        foregroundColor: Color = .gray,
        cornerRadius: CGFloat = 38,
        @ViewBuilder content: () -> Content = { EmptyView() },
        action: @escaping () -> Void
    ) {
        self.type = type
        self.disabled = disabled
        self.buttonHorizontalMargins = buttonHorizontalMargins
        self.font = font
        self.fontSize = fontSize
        self.action = action
        self.content = content()
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }

    var body: some View {
        HStack {
            Spacer(minLength: buttonHorizontalMargins)
            Button(action: action) {
                if case .prayerSound = type {
                    content
                } else {
                    Text(type.title)
                        .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(
                LargeButtonStyle(
                    type: type,
                    isDisabled: disabled,
                    font: font,
                    fontSize: fontSize,
                    cornerRadius: cornerRadius,
                    backgroundColor: backgroundColor,
                    foregroundColor: foregroundColor
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
    let cornerRadius: CGFloat
    let backgroundColor: Color
    let foregroundColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        let currentForegroundColor = isDisabled || configuration.isPressed ? foregroundColor.opacity(0.3) : foregroundColor
        
        return configuration.label
            .padding()
            .foregroundColor(currentForegroundColor)
            .background(configuration.isPressed ? backgroundColor.opacity(0.3) : backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay(type.isNeedBorder ? RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(currentForegroundColor, lineWidth: 1)
            : nil)
            .customFont(font, size: fontSize)
    }
}

