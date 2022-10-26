//
//  UIAplication+RootVC.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 05.10.2022.
//

import UIKit

extension UIApplication {
    static func rootVC() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return nil
        }
        guard let rootViewController = windowScene.windows.first?.rootViewController else {
            return nil
        }

        return rootViewController
    }
}
