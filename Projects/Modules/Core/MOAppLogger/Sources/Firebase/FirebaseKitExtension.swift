//
//  FirebaseKitExtension.swift
//  AnalyticsKit
//
//  Created by minsone on 2021/06/23.
//  Copyright © 2021 minsone. All rights reserved.
//

import Foundation
import FirebaseAnalytics

extension AppLogEventAttribute {
    var analyticsParameter: [String: Any] {
        switch self {
        case .itemId(let value):
            return [AnalyticsParameterItemID: value]
        case .itemName(let value):
            return [AnalyticsParameterItemName: value]
        case .contentType(let value):
            return [AnalyticsParameterContentType: value]
        }
    }
}
