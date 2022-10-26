//
//  TabBarAppearance.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 12.10.2022.
//

import SwiftUI

struct TabBarAppearance: ViewModifier {

    init(backgroundColor: UIColor) {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = backgroundColor
    }

    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func tabBarAppearance(backgroundColor: UIColor = .white) -> some View {
        modifier(TabBarAppearance(backgroundColor: backgroundColor))
    }
}
