//
//  NavBarBackground.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 06.10.2022.
//

import Foundation

import SwiftUI

enum NavType {
    case color(Color)
    case gradient([Color])
}

// MARK: - NavigationBackButton

struct NavBarBackground: ViewModifier {

    let type: NavType

    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Group {
                        if case .color(let color) = type {
                            color
                        } else if case .gradient(let colors) = type {
                            LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing)
                        }
                    }
                    .frame(height: geometry.safeAreaInsets.top)
                    .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

// MARK: - NavigationBackButton Modifier

extension View {
    func navBarBackground(type: NavType) -> some View {
        modifier(NavBarBackground(type: type))
    }
}
