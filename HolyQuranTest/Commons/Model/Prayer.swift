//
//  Prayer.swift
//  HolyQuranTest
//
//  Created by Александр Ковалев on 30.10.2022.
//

import Foundation

struct Prayer: Identifiable, Hashable {
    let id: UUID = UUID()
    let title: String
    let time: String
    var prayerSound: PrayerSound
    
    static func get() -> [Prayer] {
        return [
            .init(title: "Fajr", time: "04:19",  prayerSound: .alarmClockSound),
            .init(title: "Sunrise", time: "12:19", prayerSound: .none),
            .init(title: "Dhur", time: "15:19", prayerSound: .azan),
            .init(title: "Asr", time: "20:19", prayerSound: .vibrate),
            .init(title: "Magrib", time: "22:19", prayerSound: .standartNotification),
            .init(title: "Isha", time: "23:19", prayerSound: .vibrate)
        ]
    }
    
    static func mockPrayer() -> Prayer {
        .init(title: "Fajr", time: "04:19",  prayerSound: .alarmClockSound)
    }
}
