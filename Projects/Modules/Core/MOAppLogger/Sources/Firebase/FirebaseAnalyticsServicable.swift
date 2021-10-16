//
//  FirebaseAnalyticsInterface.swift
//  MOAppLogger
//
//  Created by minsone on 2021/10/09.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation
import UIKit
import MOThirdPartyLibManager
import FirebaseAnalytics
import FirebaseCore

public protocol FirebaseAnalyticsServicable {
    func register(bundle: Bundle, plistName: String)
    func logEvent(event: AppLogEvent)
    func logEvent(event: AppLogEvent, attr: AppLogEventAttribute...)
    func logEvent(event: AppLogEvent, attr: [AppLogEventAttribute])
}

struct FirebaseAnalyticsService: FirebaseAnalyticsServicable {
    func register(bundle: Bundle, plistName: String) {
        bundle.path(forResource: plistName, ofType: "plist")
            .flatMap { FirebaseOptions(contentsOfFile: $0) }
            .flatMap { FirebaseApp.configure(options: $0) }
    }

    func logEvent(event: AppLogEvent) {
        logEvent(event: event, attr: [])
    }

    func logEvent(event: AppLogEvent, attr: AppLogEventAttribute...) {
        logEvent(event: event, attr: attr)
    }

    func logEvent(event: AppLogEvent, attr: [AppLogEventAttribute]) {
        var dict: [String: Any] = [:]
        attr.forEach { dict.merge($0.analyticsParameter) { _, new in new } }
        Analytics.logEvent(event.rawValue, parameters: dict)
    }
}
