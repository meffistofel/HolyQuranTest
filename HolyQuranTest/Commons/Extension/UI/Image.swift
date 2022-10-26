//
//  Image.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 29.08.2022.
//

import SwiftUI

extension Image {
    func custom(cornerRadius: CGFloat = 0) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(cornerRadius)
    }
}
