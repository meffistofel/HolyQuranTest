//
//  Log.swift
//  Test
//
//  Created by Oleksandr Kovalov on 17.08.2022.
//

import Foundation

public final class Log {

    /// Not so important đ
    static func verbose(_ message: Any) {
        let appendix = "đ VERBOSE -"
        print(appendix, message)
    }

    /// Something to debug đ
    static func debug(_ message: Any) {
        let appendix = "đ DEBUG -"
        print(appendix, message)
    }

    /// Good to know âšī¸
    static func info(_ message: Any) {
        let appendix = "âšī¸ INFO -"
        print(appendix, message)
    }

    /// Something bad happened â ī¸
    static func warning(_ message: Any) {
        let appendix = "â ī¸ WARNING -"
        print(appendix, message)
    }

    /// ERROR!!!! âī¸
    static func error(_ message: Any) {
        let appendix = "âī¸ ERROR -"
        print(appendix, message)
    }

    /// Deinitialization!!!!
    static func deinitialize(_ message: Any) {
        let appendix = "DEINIT -----> "
        print(appendix, message)
    }
}
