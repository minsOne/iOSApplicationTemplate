//
//  LoggerFirebaseMock.swift
//  MOAppLoggerTests
//
//  Created by minsone on 2021/10/09.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation
@testable import MOAppLogger

final class FirebaseAnalyticsServiceMock: FirebaseAnalyticsServicable {
    var registerCount = 0
    var logEventCount = 0

    init() {}

    func register(bundle: Bundle, plistName: String) {
        registerCount += 1
    }

    func logEvent(event: AppLogEvent) {
        logEvent(event: event, attr: [])
    }

    func logEvent(event: AppLogEvent, attr: AppLogEventAttribute...) {
        logEvent(event: event, attr: attr)
    }

    func logEvent(event: AppLogEvent, attr: [AppLogEventAttribute]) {
        logEventCount += 1
    }
}
