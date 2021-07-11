//
//  FirebaseKit.swift
//  AnalyticsKit
//
//  Created by minsone on 2021/06/23.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation
import ThirdPartyLibraryManager
import Firebase
import UIKit

public extension Logger {
    final class Firebase {
        public init() {}
    }
}

public protocol FirebaseAnalyticsInterface {
    static func register(bundle: Bundle, plistName: String)
    static func logEvent(event: AppLogEvent)
    static func logEvent(event: AppLogEvent, attr: AppLogEventAttribute...)
    static func logEvent(event: AppLogEvent, attr: [AppLogEventAttribute])
}

extension Logger.Firebase: FirebaseAnalyticsInterface {
    public static func register(bundle: Bundle, plistName: String) {
        bundle.path(forResource: plistName, ofType: "plist")
            .flatMap { FirebaseOptions(contentsOfFile: $0) }
            .flatMap { FirebaseApp.configure(options: $0) }
    }

    public static func logEvent(event: AppLogEvent) {
        logEvent(event: event, attr: [])
    }

    public static func logEvent(event: AppLogEvent, attr: AppLogEventAttribute...) {
        logEvent(event: event, attr: attr)
    }

    public static func logEvent(event: AppLogEvent, attr: [AppLogEventAttribute]) {
        var dict: [String: Any] = [:]
        attr.forEach { dict.merge($0.analyticsParameter) { _, new in new } }
        Analytics.logEvent(event.rawValue, parameters: dict)
    }
}
