//
//  dsdsa.swift
//  HolyQuranTest
//
//  Created by Oleksandr Kovalov on 26.10.2022.
//

import Foundation
import Combine
import CoreLocation
import SwiftUI

// MARK: - CompassHeading

class CompassHeading: NSObject, ObservableObject, CLLocationManagerDelegate {

    // MARK: - Properties

    var objectWillChange = PassthroughSubject<Void, Never>()
    var degrees: Double = .zero {
        didSet {
            objectWillChange.send()
        }
    }

    var angle: CGFloat = 0

    private let locationManager: CLLocationManager

    // MARK: - Init

    override init() {
        self.locationManager = CLLocationManager()
        super.init()

        self.locationManager.delegate = self
        self.setup()
    }

    // MARK: - Properties

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        angle += angleDiff(to: newHeading.magneticHeading)
        self.degrees = -1 * angle
    }
}

// MARK: - Private Extension

private extension CompassHeading {
    func setup() {
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.headingAvailable() {
            self.locationManager.startUpdatingLocation()
            self.locationManager.startUpdatingHeading()
        }
    }

    func clampAngle(_ angle: CGFloat) -> CGFloat {
        var angle = angle
        while angle < 0 {
            angle += 360
        }
        return angle.truncatingRemainder(dividingBy: 360)
    }

    // Calculates the difference between heading and angle
    func angleDiff(to heading: CGFloat) -> CGFloat {
        return (clampAngle(heading - self.angle) + 180).truncatingRemainder(dividingBy: 360) - 180
    }
}

