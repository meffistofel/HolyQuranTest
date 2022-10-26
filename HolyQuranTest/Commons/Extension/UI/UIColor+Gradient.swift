//
//  UIColor+Gradient.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 05.10.2022.
//

import UIKit

// MARK: - Hex init
extension UIColor {
    static func getColor(from hex: String) -> UIColor {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 1.0
        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return .clear }
        switch length {
        case 6:
            red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            blue = CGFloat(rgb & 0x0000FF) / 255.0
        case 8:
            red = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            green = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            blue = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            alpha = CGFloat(rgb & 0x000000FF) / 255.0
        default:
            return .clear
        }
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

// MARK: - Colors
extension UIColor {
    static let firstGradientColor = UIColor.getColor(from: "FFA400")
    static let secondGradientColor = UIColor.getColor(from: "FF7F00")
    static let grayColor = UIColor.getColor(from: "4D4D4D")
    static let errorRedColor = UIColor.getColor(from: "A22027")
    static let inactiveGrayColor = UIColor.getColor(from: "C1C1C1")
    static let inactiveLightGrayColor = UIColor.getColor(from: "EDEDED")
    static let inactiveCreamGrayColor = UIColor.getColor(from: "F7F7F7")
    static let inputBlackColor = UIColor.getColor(from: "1B1B1B")
    static let grayTextColor = UIColor.getColor(from: "616161")
    static let orangeTextColor = UIColor.getColor(from: "FF7F00")
    static let creamOrangeColor = UIColor.getColor(from: "FAF0E6")

    enum GradientFlow {
        case horizontal
        case vertical
    }



    static func getAppGradientColor(horizontal: Bool = true) -> UIColor {
        guard let rootViewController = UIApplication.rootVC() else {
            return .clear
        }

        let size = CGSize(width: rootViewController.view.bounds.width, height: 64)

        return UIColor.getGradientUIColor(from: [.firstGradientColor, .secondGradientColor], with: size, horizontal: horizontal)
    }

    static func getGradientUIColor(from colors: [UIColor], with size: CGSize, horizontal: Bool = true) -> UIColor {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        gradient.colors = colors.map({ $0.cgColor })
        gradient.locations = [0, 1]
        let startPoint = horizontal ? CGPoint(x: 0.25, y: 0.5) : CGPoint(x: 0.5, y: 0.0)
        let endPoint = horizontal ? CGPoint(x: 0.75, y: 0.5) : CGPoint(x: 0.5, y: 1.0)
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else { return .clear }
        gradient.render(in: context)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIColor(patternImage: newImage ?? UIImage())
    }
}



