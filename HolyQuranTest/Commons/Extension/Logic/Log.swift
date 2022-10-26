//
//  Log.swift
//  Test
//
//  Created by Oleksandr Kovalov on 17.08.2022.
//

import Foundation

public final class Log {

    /// Not so important 💜
    static func verbose(_ message: Any) {
        let appendix = "💜 VERBOSE -"
        print(appendix, message)
    }

    /// Something to debug 💚
    static func debug(_ message: Any) {
        let appendix = "💚 DEBUG -"
        print(appendix, message)
    }

    /// Good to know ℹ️
    static func info(_ message: Any) {
        let appendix = "ℹ️ INFO -"
        print(appendix, message)
    }

    /// Something bad happened ⚠️
    static func warning(_ message: Any) {
        let appendix = "⚠️ WARNING -"
        print(appendix, message)
    }

    /// ERROR!!!! ⛔️
    static func error(_ message: Any) {
        let appendix = "⛔️ ERROR -"
        print(appendix, message)
    }

    /// Deinitialization!!!!
    static func deinitialize(_ message: Any) {
        let appendix = "DEINIT -----> "
        print(appendix, message)
    }
}
