//
//  Conditional.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 19.10.2022.
//

import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
