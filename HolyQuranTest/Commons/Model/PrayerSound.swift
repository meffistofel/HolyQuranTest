//
//  PrayerSound.swift
//  HolyQuranTest
//
//  Created by Александр Ковалев on 30.10.2022.
//

import Foundation

enum PrayerSound: CaseIterable {
    case none
    case azan
    case vibrate
    case silentNotification
    case standartNotification
    case alarmClockSound
    
    var text: String {
        switch self {
        case .none:
            return "None".localized()
        case .azan:
            return "Azan".localized()
        case .vibrate:
            return "Vibrate".localized()
        case .silentNotification:
            return "Silent Notification".localized()
        case .standartNotification:
            return "Standard Text Tone".localized()
        case .alarmClockSound:
            return "Alarm clock sound".localized()
        }
    }
    
    var image: String {
        switch self {
        case .none:
            return "ico_prayer_sound_none"
        case .azan:
            return "ico_prayer_sound_volume"
        case .vibrate:
            return "ico_prayer_sound_vibrate"
        case .silentNotification:
            return "ico_prayer_sound_silent"
        case .standartNotification:
            return "ico_prayer_sound_standart"
        case .alarmClockSound:
            return "ico_prayer_sound_alarm"
        }
    }
}
