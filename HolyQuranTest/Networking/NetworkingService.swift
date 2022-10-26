//
//  Networking.swift
//  Test
//
//  Created by Oleksandr Kovalov on 16.08.2022.
//

import Foundation

// MARK: - NetworkServiceProtocol

protocol NetworkServiceProtocol: AnyObject {
    @discardableResult
    func call<T: Decodable>(_ resource: Resource<T>) async throws -> T
}

//MARK: - NetworkService

final class NetworkingService: NetworkServiceProtocol {

    // MARK: - Properties

    private let session: URLSession
    private let networkMonitoringService: NetworkMonitoringService

    // MARK: - Init

    init(
        session: URLSession = URLSession(configuration: URLSessionConfiguration.ephemeral), networkMonitoringService: NetworkMonitoringService
    ) {
        self.session = session
        self.networkMonitoringService = networkMonitoringService
    }

    // MARK: - Methods

    @discardableResult
    func call<T: Decodable>(_ resource: Resource<T>) async throws -> T {
        
        let request = try resource.createRequest()

        guard networkMonitoringService.isNetworkAvailable else {
            throw APIError.noInternetConnection
        }

        let (data, response) = try await session.data(for: request)

        Log.debug("Response: ------------------- \(String(data: data, encoding: .utf8) as Any)")

        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            throw APIError.unexpectedResponse
        }
        guard HTTPCodes.success.contains(code) else {
            throw APIError.httpCode(code)
        }

        let model = try JSONDecoder().decode(T.self, from: data)

        Log.debug("Decoded model: ------------------- \(model)")

        return model
    }
}
