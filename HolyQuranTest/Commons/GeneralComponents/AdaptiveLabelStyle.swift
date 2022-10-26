//
//  CustomLabel.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 11.10.2022.
//

import SwiftUI

struct AdaptiveLabelStyle: LabelStyle {
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?

    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }

//        if verticalSizeClass == .compact {
//            // 1
//            HStack {
//                configuration.title
//                configuration.icon
//            }
//        } else {
//            // 2
//            VStack {
//                configuration.title
//                configuration.icon
//            }
//        }
    }
}
