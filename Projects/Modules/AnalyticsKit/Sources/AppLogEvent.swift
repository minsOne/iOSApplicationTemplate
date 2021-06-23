//
//  AppLogEvent.swift
//  AnalyticsKit
//
//  Created by minsone on 2021/06/23.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation

public enum AppLogEvent: String {
    case appStart
}

extension AppLogEvent {
    public var rawValue: String {
        switch self {
        case .appStart: return "AppStart"
        }
    }
}

public enum AppLogEventAttribute {
    case itemId(String)
    case itemName(String)
    case contentType(String)
}
