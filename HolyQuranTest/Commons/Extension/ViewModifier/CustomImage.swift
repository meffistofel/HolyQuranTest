//
//  CustomImage.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 12.10.2022.
//

import SwiftUI

extension Image {

    func customListImage(size: CGFloat = 20) -> some View {
        self
            .renderingMode(.template)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .modifier(ColorInvert())
    }
}


