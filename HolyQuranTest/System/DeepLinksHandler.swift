//
//  DeepLinksHandler.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 25.08.2022.
//

import Foundation

enum DeepLink: Equatable {

    case newCase(someCode: String)

    init?(url: URL) {
        guard
            let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
            components.host == "www.example.com",
            let query = components.queryItems
            else { return nil }
        if let item = query.first(where: { $0.name == "someValue" }),
            let code = item.value {
            self = .newCase(someCode: code)
            return
        }
        return nil
    }
}

protocol DeepLinksHandlerProtocol {
    func open(deepLink: DeepLink)
}

struct DeepLinksHandler: DeepLinksHandlerProtocol {

    private let container: DependencyContainer

    init(container: DependencyContainer) {
        self.container = container
    }

    func open(deepLink: DeepLink) {
        switch deepLink {
        case let .newCase(someCode: code) :
            print("Code: \(code)")
        }
    }
}
