//
//  SheetPresented.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 18.10.2022.
//

import SwiftUI

struct SheetPresenter<Content>: View where Content: View {

    @Environment(\.container) private var container: DependencyContainer
    @Binding var presentingSheet: Bool

    let content: Content
    let onAppearAction: EmptyClosure

    var body: some View {
        Text("")
            .fullScreenCover(isPresented: $presentingSheet, content: {
                content
                    .inject(container)
                    .environment(\.colorScheme, .light)
            })
            .onAppear {
                DispatchQueue.main.async {
                    onAppearAction()
                }
            }
    }
}
