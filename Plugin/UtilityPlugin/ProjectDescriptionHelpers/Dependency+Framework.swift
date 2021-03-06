//
//  FrameworkDependency.swift
//  UtilityPlugin
//
//  Created by minsone on 2021/06/01.
//

import Foundation
import ProjectDescription

// MARK: Framework
extension Dep {
    public struct Framework {
        public struct Common {}
        public struct DesignSystem {}
        public struct DevelopTool {}
        public struct Vendor {}

        public struct Example {}
        public struct Tests {}
    }
}

// MARK: - Common
public extension Dep.Framework.Common {
    private static func framework(name: String) -> Dep { .xcframework(path: .relativeToRoot("Libraries/Common/\(name).xcframework")) }
    
    static let ReactorKit: [Dep] = [
        framework(name: "ReactorKit"),
        framework(name: "ReactorKitRuntime"),
        framework(name: "WeakMapTable")
    ]
    static let RIBs              = framework(name: "RIBs")
    static let RxCocoa           = framework(name: "RxCocoa")
    static let RxRelay           = framework(name: "RxRelay")
    static let RxSwift           = framework(name: "RxSwift")
}

// MARK: - DesignSystem
public extension Dep.Framework.DesignSystem {
    private static func framework(name: String) -> Dep { .xcframework(path: .relativeToRoot("Libraries/DesignSystem/\(name).xcframework")) }

    static let FlexLayout = framework(name: "FlexLayout")
    static let PinLayout  = framework(name: "PinLayout")
    static let SnapKit    = framework(name: "SnapKit")
}

// MARK: - DevelopTool
public extension Dep.Framework.DevelopTool {
    private static func framework(name: String) -> Dep { .xcframework(path: .relativeToRoot("Libraries/DevelopTool/\(name).xcframework")) }

    static let FLEX               = framework(name: "FLEX")
    static let Nimble             = framework(name: "Nimble")
    static let Quick              = framework(name: "Quick")
    static let RxBlocking         = framework(name: "RxBlocking")
    static let RxNimbleRxBlocking = framework(name: "RxNimbleRxBlocking")
    static let RxNimbleRxTest     = framework(name: "RxNimbleRxTest")
    static let RxTest             = framework(name: "RxTest")
    static let TouchVisualizer    = framework(name: "TouchVisualizer")
}

// MARK: - Vendor
public extension Dep.Framework.Vendor {
    private static func firebase(name: String) -> Dep { .xcframework(path: .relativeToRoot("Libraries/Vendor/Firebase/\(name).xcframework")) }
    private static func facebook(name: String) -> Dep { .framework(path: .relativeToRoot("Libraries/Vendor/Facebook/\(name).framework")) }

    static let Firebase: [Dep] = [
        firebase(name: "FirebaseAnalytics"),
        firebase(name: "FirebaseCore"),
        firebase(name: "FirebaseCoreDiagnostics"),
        firebase(name: "FirebaseCrashlytics"),
        firebase(name: "FirebaseInstallations"),
        firebase(name: "GoogleAppMeasurement"),
        firebase(name: "GoogleDataTransport"),
        firebase(name: "GoogleUtilities"),
        firebase(name: "nanopb"),
        firebase(name: "PromisesObjC"),
    ]
    static let Facebook: [Dep] = [
        facebook(name: "FBSDKShareKit"),
        facebook(name: "FBSDKLoginKit"),
        facebook(name: "FBSDKGamingServicesKit"),
        facebook(name: "FBSDKCoreKit"),
        facebook(name: "FBSDKCoreKit_Basics"),
    ]
}
