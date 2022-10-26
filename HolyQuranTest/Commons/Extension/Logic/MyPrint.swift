//
//  MyPrint.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 22.10.2022.
//

import SwiftUI

extension View {
    func myPrint(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}
