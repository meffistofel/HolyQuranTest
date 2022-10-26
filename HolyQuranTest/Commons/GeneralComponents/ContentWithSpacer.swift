//
//  ContentWithSpacer.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 26.10.2022.
//

import SwiftUI

enum SpacerType {
    case leading
    case trailing
    case bottom
    case top
}

struct ContentWithSpacer<Content: View>: View {
    let content: Content
    let contentAlignment: SpacerType
    var spacing: CGFloat?

    init(
        contentAlignment: SpacerType,
        spacing: CGFloat? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.contentAlignment = contentAlignment
        self.spacing = spacing
        self.content = content()
    }

    var body: some View {
        if contentAlignment == .bottom {
            VStack {
                Spacer()
                content
            }
        } else if contentAlignment == .top {
            VStack {
                content
                Spacer()
            }
        } else if contentAlignment == .leading {
            HStack {
                content
                Spacer()
            }
        } else {
            HStack {
                Spacer()
                content
            }
        }
    }
}

