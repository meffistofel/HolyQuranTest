//
//  PushTokenWebRepository.swift
//  DepartmentSwiftUI
//
//  Created by Oleksandr Kovalov on 25.08.2022.
//

import Combine
import Foundation

protocol PushTokenWebRepositoryProtocol {
    func register(devicePushToken: Data) async throws
}

struct PushTokenWebRepository: PushTokenWebRepositoryProtocol {

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func register(devicePushToken: Data) async throws {
        try await networkService.call(
            Resource<Human>(
                route: "user",
                v: "v2",
                httpMethod: .post
            )
        )
    }
}


struct Human: Decodable {
    let name: String
}
