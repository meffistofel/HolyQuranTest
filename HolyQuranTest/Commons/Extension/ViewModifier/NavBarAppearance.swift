//
//  NavBarAppearance.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 25.10.2022.
//

import SwiftUI

enum UINavigationBarAppearanceType {
    case defaultAppear
    case opaque
    case transparent
}

struct NavBarAppearance: ViewModifier {

    init(type: UINavigationBarAppearanceType, needNavBarBackGroundImage: Bool) {
        let appearance = customNavBarAppearance(type)
        let scrollAppearance = customNavBarAppearance(type)

        if needNavBarBackGroundImage {
//            scrollAppearance.backgroundImage = UIImage(named: Constants.Image.navCarImage)!
        }

        UINavigationBar.appearance().scrollEdgeAppearance = scrollAppearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance

        if #available(iOS 15.0, *) {
            UINavigationBar.appearance().compactScrollEdgeAppearance = scrollAppearance
        }
    }

    func body(content: Content) -> some View {
        content
    }

    private func customNavBarAppearance(
        _ type: UINavigationBarAppearanceType,
        titleColor: UIColor = .black,
        largeTitleColor: UIColor = .black,
        buttonColor: UIColor = .black
    ) -> UINavigationBarAppearance {
        let customNavBarAppearance = UINavigationBarAppearance()

        // change type nav bar
        switch type {
        case .defaultAppear:
            customNavBarAppearance.configureWithDefaultBackground()
            customNavBarAppearance.backgroundColor = .white
        case .opaque:
            customNavBarAppearance.configureWithOpaqueBackground()
            customNavBarAppearance.backgroundColor = .white
            customNavBarAppearance.shadowColor = .clear
        case .transparent:
            customNavBarAppearance.configureWithTransparentBackground()
        }

        // Apply white colored normal and large titles.
        customNavBarAppearance.titleTextAttributes = [.foregroundColor: titleColor, .font: UIFont(name: "Poppins Black", size: 20)!]
        customNavBarAppearance.largeTitleTextAttributes = [.foregroundColor: largeTitleColor]
        // Apply white color to all the nav bar buttons.
        let barButtonItemAppearance = UIBarButtonItemAppearance(style: .plain)
        barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: buttonColor]
        barButtonItemAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.lightText]
        barButtonItemAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.label]
        barButtonItemAppearance.focused.titleTextAttributes = [.foregroundColor: buttonColor]

        customNavBarAppearance.buttonAppearance = barButtonItemAppearance
        customNavBarAppearance.backButtonAppearance = barButtonItemAppearance
        customNavBarAppearance.doneButtonAppearance = barButtonItemAppearance

        UINavigationBar.appearance().tintColor = .black

        // set custom Image in back buttton
//        customNavBarAppearance.setBackIndicatorImage(type.backImage, transitionMaskImage: type.backImage)

        return customNavBarAppearance
    }
}

extension View {
    func navigationAppearance(type: UINavigationBarAppearanceType, needNavBarBackGroundImage: Bool = false) -> some View {
        modifier(NavBarAppearance(type: type, needNavBarBackGroundImage: needNavBarBackGroundImage))
    }
}
