//
//  CustomUserDefaultrs.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 03.10.2022.
//

import Foundation

enum UserDefaultsKeys {
    static let isShowOnboarding = "isShowOnboarding"
}

extension UserDefaults {
    @UserDefaultsBacked<Bool>(key: UserDefaultsKeys.isShowOnboarding)
    static var isShowOnboarding: Bool = false
}

private protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}

@propertyWrapper struct UserDefaultsBacked<Value> {
    private let key: String
    private let defaultValue: Value
    private let storage: UserDefaults


    var wrappedValue: Value {
        get {
            let value = storage.value(forKey: key) as? Value
            return value ?? defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                storage.removeObject(forKey: key)
            } else {
                storage.setValue(newValue, forKey: key)
            }
        }
    }

    init(wrappedValue defaultValue: Value, key: String, storage: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }

}

extension UserDefaultsBacked where Value: ExpressibleByNilLiteral {
    init(key: String, storage: UserDefaults = .standard) {
        self.init(wrappedValue: nil, key: key, storage: storage)
    }
}
