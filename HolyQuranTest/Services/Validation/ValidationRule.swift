//
//  ValidationRule.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 30.08.2022.
//

import Foundation

extension String {

    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: self)
        return result
    }

    var isValidPassword: Bool {
        self.count >= 6
//        let emailRegEx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$"
//        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
//        let result = emailTest.evaluate(with: self)
//        return result
    }

    var isValidFullName: Bool {
        self.count >= 6
    }

    var isValidUserName: Bool {
        self.count >= 6
    }

    var isValidPhoneNumber: Bool {
        self.count >= 6
    }

    var isValidFullNameShowroom: Bool {
        self.count >= 6
    }

    var isValidCommercialNumber: Bool {
        self.count >= 6
    }
}
