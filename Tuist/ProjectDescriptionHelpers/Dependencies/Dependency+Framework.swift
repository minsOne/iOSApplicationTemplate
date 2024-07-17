//
//  FrameworkDependency.swift
//  ProjectDescriptionHelpers
//
//  Created by minsone on 2021/06/01.
//

import Foundation
import ProjectDescription

// MARK: Framework
public extension Dep {
    struct Framework {}
}

public extension Dep.Framework {
    static let Firebase: [Dep] = [
        .firebase(name: "nanopb"),
        .firebase(name: "GoogleUtilities"),
        .firebase(name: "GoogleAppMeasurementIdentitySupport"),
        .firebase(name: "GoogleAppMeasurement"),
        .firebase(name: "FirebaseInstallations"),
        .firebase(name: "FirebaseCoreInternal"),
        .firebase(name: "FirebaseCore"),
        .firebase(name: "FirebaseAnalytics"),
        .firebase(name: "FBLPromises"),
    ]
    static let Facebook: [Dep] = [
        .facebook(name: "FBSDKShareKit"),
        .facebook(name: "FBSDKLoginKit"),
        .facebook(name: "FBSDKGamingServicesKit"),
        .facebook(name: "FBSDKCoreKit"),
        .facebook(name: "FBSDKCoreKit_Basics"),
    ]
    static let FlexLayout = Dep.designSystem(name: "FlexLayout")
    static let PinLayout = Dep.designSystem(name: "PinLayout")
    static let SnapKit = Dep.designSystem(name: "SnapKit")
}

public extension Dep {
    static func firebase(name: String) -> Self {
        return .xcframework(path: .relativeToRoot("Vendor/Firebase/\(name).xcframework"))
    }
    static func facebook(name: String) -> Self {
        return .xcframework(path: .relativeToRoot("Vendor/Facebook/\(name).xcframework"))
    }
    static func designSystem(name: String) -> Self {
        return .xcframework(path: .relativeToRoot("Vendor/DesignSystem/\(name).xcframework"))
    }
}
