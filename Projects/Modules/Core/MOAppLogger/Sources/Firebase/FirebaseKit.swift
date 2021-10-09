//
//  FirebaseKit.swift
//  AnalyticsKit
//
//  Created by minsone on 2021/06/23.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation

extension Logger {
    public final class Firebase {
        static var service: FirebaseAnalyticsServicable = FirebaseAnalyticsService()
    }
}

extension Logger.Firebase {
    public static func register(bundle: Bundle, plistName: String) {
        service.register(bundle: bundle, plistName: plistName)
    }

    public static func logEvent(event: AppLogEvent) {
        service.logEvent(event: event)
    }

    public static func logEvent(event: AppLogEvent, attr: AppLogEventAttribute...) {
        service.logEvent(event: event, attr: attr)
    }

    public static func logEvent(event: AppLogEvent, attr: [AppLogEventAttribute]) {
        service.logEvent(event: event, attr: attr)
    }
}
