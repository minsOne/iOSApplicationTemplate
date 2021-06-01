//
//  FrameworkDependency.swift
//  UtilityPlugin
//
//  Created by minsone on 2021/06/01.
//

import Foundation
import ProjectDescription

// MARK: Framework
public extension TargetDependency {
    struct Framework {}
}

public extension TargetDependency.Framework {
    static let Firebase: [TargetDependency] = [
        .firebase(name: "nanopb"),
        .firebase(name: "GoogleUtilities"),
        .firebase(name: "GoogleDataTransportCCTSupport"),
        .firebase(name: "GoogleDataTransport"),
        .firebase(name: "GoogleAppMeasurement"),
        .firebase(name: "FirebaseCoreDiagnostics"),
        .firebase(name: "FirebaseInstanceID"),
        .firebase(name: "FirebaseCore"),
        .firebase(name: "FirebaseAnalytics"),
        .firebase(name: "Firebase"),
        .firebase(name: "FIRAnalyticsConnector"),
    ]
}

public extension TargetDependency {
    static func firebase(name: String) -> Self {
        return .framework(path: .relativeToRoot("Vendor/Firebase/\(name).framework"))
    }
}
