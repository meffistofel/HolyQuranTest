//
//  Optional.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 26.08.2022.
//

import Foundation

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}
