//
//  CustomLabel.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 23.10.2022.
//

import SwiftUI

struct CustomText: View {

    let text: String
    let font: (FontBook, CGFloat)
    let foregroundColor: Color

    var body: some View {
        Text(text)
            .customFont(font.0, size: font.1)
            .foregroundColor(foregroundColor)
    }
}
