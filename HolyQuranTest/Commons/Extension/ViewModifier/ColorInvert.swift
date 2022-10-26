//
//  ColorInvert.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 12.10.2022.
//

import SwiftUI

struct ColorInvert: ViewModifier {

    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        Group {
            if colorScheme == .dark {
                content.colorInvert()
            } else {
                content
            }
        }
    }
}
