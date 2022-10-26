//
//  Constants.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 24.08.2022.
//

import Foundation
import SwiftUI

class Constants { }

// MARK: - Image & Ico

extension Constants {
    class Image {
        //Tab bar
        static let iconHome = "icon_home"
        static let iconIdea = "icon_idea"
        static let iconQuran = "icon_quran"
        static let iconQuibla = "icon_quibla"
        static let iconSettings = "icon_settings"

        //Nav bar
        static let iconSearch = "icon_search"
        static let iconQuranSettings = "icon_quran_settings"
        static let logo = "logo"
        static let imageSplashLogo = "image_splash_logo"

        //Prayer
        static let iconListening = "icon_listening"
        static let iconReading = "icon_reading"

        //Quibla
        static let iconCurrentLocation = "icon_current_location"

        //Settings
        static let iconArrow = "icon_arrow"
    }
}

// MARK: - KeychainType

extension Constants {

    enum KeychainType {
        case appleId
        case facebook
        case google

        var service: String {
            switch self {
            case .appleId:
                return "com.department-SwiftUI-apple"
            case .facebook:
                return "com.department-SwiftUI-facebook"
            case .google:
                return "com.department-SwiftUI-google"
            }
        }

        var account: String? {
            switch self {
            case .appleId:
                return "userIdentifier-apple"
            case .facebook:
                return "userIdentifier-facebook"
            case .google:
                return "userIdentifier-google"
            }
        }

        var accessGroup: String? {
            switch self {
            case .appleId, .facebook, .google:
                return nil
            }
        }
    }
}
