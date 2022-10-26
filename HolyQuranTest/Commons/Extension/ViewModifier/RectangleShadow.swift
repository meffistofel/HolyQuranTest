//
//  RectangleShadow.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 26.10.2022.
//

import SwiftUI

struct RectangleShadow: ViewModifier {
    let color: Color
    let radius: CGFloat
    var cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .background(RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.white)
                .shadow(color: color, radius: radius))
    }
}

extension View {
    func addShadowToRectangle(color: Color, radius: CGFloat, cornerRadius: CGFloat = 0) -> some View {
        modifier(RectangleShadow(color: color, radius: radius, cornerRadius: cornerRadius))
    }
}
