//
//  ActionRow.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 14.10.2022.
//

import SwiftUI

struct ActionRow<Content: View> : View {

    let menu: ActionRowType
    let content: Content
    let isNeedDivider: (top: Bool, bottom: Bool)
    let padding: (edge: Edge.Set, spacing: CGFloat)

    var onTap: EmptyClosure?


    init(menu: ActionRowType, isNeedDivider: (top: Bool, bottom: Bool) = (false, false), padding: (Edge.Set, CGFloat) = (edge: [.top], spacing: 16), onTap: EmptyClosure? = nil, @ViewBuilder content: () -> Content = { Image(Constants.Image.iconArrow) }) {
        self.menu = menu
        self.isNeedDivider = isNeedDivider
        self.padding = padding
        self.onTap = onTap
        self.content = content()
    }

    var body: some View {
        VStack {
            if isNeedDivider.top {
                Divider()
            }
            HStack {
                Text(menu.title)
                    .customFont(.bold, size: 16)
                    .foregroundColor(.black)
                Spacer()

                content
            }
            .padding(padding.edge, padding.spacing)
            if isNeedDivider.bottom {
                Divider()
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onTap?()
        }
    }
}

struct ActionRow_Previews: PreviewProvider {
    static var previews: some View {
        ActionRow(menu: .none)
    }
}
