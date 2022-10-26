//
//  Color.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 29.08.2022.
//

import SwiftUI

extension Color {

    // MARK: - Color

    // Text

    public static var qiblaDirection: Color {
        Color("qiblaDirection")
    }

    public static var startGradient: Color {
        Color("startGradient")
    }

    public static var endGradient: Color {
        Color("endGradient")
    }

    public static var gradient: [Color] {
        [startGradient, endGradient]
    }
}
