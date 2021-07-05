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
    func register(bundle: Bundle, plistName: String)
    func logEvent(event: AppLogEvent)
    func logEvent(event: AppLogEvent, attr: AppLogEventAttribute...)
    func logEvent(event: AppLogEvent, attr: [AppLogEventAttribute])
}

extension Logger.Firebase: FirebaseAnalyticsInterface {
    public func register(bundle: Bundle, plistName: String) {
        bundle.path(forResource: plistName, ofType: "plist")
            .flatMap { FirebaseOptions(contentsOfFile: $0) }
            .flatMap { FirebaseApp.configure(options: $0) }
    }

    public func logEvent(event: AppLogEvent) {
        logEvent(event: event, attr: [])
    }
    
    public func logEvent(event: AppLogEvent, attr: AppLogEventAttribute...) {
        logEvent(event: event, attr: attr)
    }
    
    public func logEvent(event: AppLogEvent, attr: [AppLogEventAttribute]) {
        var dict: [String: Any] = [:]
        attr.forEach { dict.merge($0.analyticsParameter) { _, new in new } }
        Analytics.logEvent(event.rawValue, parameters: dict)
    }
}

func getImage(urlPath: String) -> UIImage? {
    return URL(string: urlPath)
        .flatMap { try? Data(contentsOf: $0) }
        .map { UIImage(data: $0) }
}
