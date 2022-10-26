//
//  NetworkingMonitoringService.swift
//  Test
//
//  Created by Oleksandr Kovalov on 17.08.2022.
//

import Foundation
import Network

// MARK: - NetworkMonitoringService

final class NetworkMonitoringService {

    // MARK: - Properties

    var isNetworkAvailable: Bool = true

    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global()

    // MARK: - Init

    init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        self.monitor.start(queue: self.queue)

        self.startMonitoring()
    }

    // MARK: - Methods

    func startMonitoring() {
        self.monitor.pathUpdateHandler = { path in
            self.isNetworkAvailable = path.status == .satisfied
        }
    }

    func stopMonitoring() {
        self.monitor.cancel()
    }
}
