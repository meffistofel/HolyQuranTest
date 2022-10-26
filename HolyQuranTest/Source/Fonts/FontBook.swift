//
//  FontBook.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 29.08.2022.
//

import SwiftUI

extension View {
    func customFont(_ font: FontBook, size: CGFloat) -> some View {
        modifier(FontModifier(font: font, size: size))
    }
}

struct FontModifier: ViewModifier {
    let font: FontBook
    let size: CGFloat

    func body(content: Content) -> some View {
        content
            .font(.custom(font.rawValue, size: size))
    }
}

enum FontBook: String {
    case black = "Poppins Black"
    case bold = "Poppins Bold"
    case extraBold = "Poppins ExtraBold"
    case extraLight = "Poppins ExtraLight"
    case light = "Poppins Light"
    case medium = "Poppins Medium"
    case regular = "Poppins Regular"
    case semibold = "Poppins SemiBold"
    case thin = "Poppins Thin"
}
