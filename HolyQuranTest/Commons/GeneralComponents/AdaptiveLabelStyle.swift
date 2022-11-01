//
//  CustomLabel.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 11.10.2022.
//

import SwiftUI

struct AdaptiveLabelStyle: LabelStyle {
//    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    
    var iconAlignment: SpacerType = .leading
    var spacing: CGFloat = 8

    func makeBody(configuration: Self.Configuration) -> some View {
        if iconAlignment == .bottom {
            VStack(spacing: spacing) {
                configuration.title
                configuration.icon
            }
        } else if iconAlignment == .top {
            VStack(spacing: spacing) {
                configuration.icon
                configuration.title
            }
        } else if iconAlignment == .leading {
            HStack(spacing: spacing) {
                configuration.icon
                configuration.title
            }
        } else {
            HStack(spacing: spacing) {
                configuration.title
                configuration.icon
            }
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
