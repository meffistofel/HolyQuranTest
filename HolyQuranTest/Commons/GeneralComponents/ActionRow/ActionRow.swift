//
//  ActionRow.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 14.10.2022.
//

import SwiftUI

struct ActionRow<Content: View, SubContent: View> : View {

    let menu: ActionRowType
    let content: Content
    let subContent: SubContent
    let isNeedDivider: (top: Bool, bottom: Bool)
    let padding: (edge: Edge.Set, spacing: CGFloat)
    var font: (type: FontBook, size: CGFloat)

    var onTap: EmptyClosure?


    init(
        menu: ActionRowType,
        isNeedDivider: (top: Bool, bottom: Bool) = (false, false),
        padding: (Edge.Set, CGFloat) = (edge: [.top], spacing: 16),
        font: (type: FontBook, size: CGFloat) = (.bold, 16),
        @ViewBuilder content: () -> Content = { Image(Constants.Image.iconArrow) },
        @ViewBuilder subContent: () -> SubContent = { EmptyView() },
        onTap: EmptyClosure? = nil
    ) {
        self.menu = menu
        self.isNeedDivider = isNeedDivider
        self.padding = padding
        self.font = font
        self.content = content()
        self.subContent = subContent()
        self.onTap = onTap
    }

    var body: some View {
        VStack {
            if isNeedDivider.top {
                Divider()
            }
            HStack {
                Text(menu.title)
                    .customFont(font.type, size: font.size)
                    .foregroundColor(.black)
                Spacer()

                HStack(spacing: 16) {
                    subContent
                    content
                }
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
        ActionRow(menu: .dayVerse)
    }
}
