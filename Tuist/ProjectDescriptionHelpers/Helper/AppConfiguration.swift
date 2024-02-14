import Foundation
import ProjectDescription

public enum AppConfiguration: String {
    case dev = "DEV"
    case test = "TEST"
    case stage = "STAGE"
    case prod = "PROD"

    public var configurationName: ConfigurationName {
        .configuration(rawValue)
    }
}

public extension String {
    static var dev: String { AppConfiguration.dev.rawValue }
    static var test: String { AppConfiguration.test.rawValue }
    static var stage: String { AppConfiguration.stage.rawValue }
    static var prod: String { AppConfiguration.prod.rawValue }
}

public extension ConfigurationName {
    static var dev: Self { AppConfiguration.dev.configurationName }
    static var test: Self { AppConfiguration.test.configurationName }
    static var stage: Self { AppConfiguration.stage.configurationName }
    static var prod: Self { AppConfiguration.prod.configurationName }
}

public enum AppInfo {
    public static let organizationName = "minsone"
    public static let deploymentTargets = DeploymentTargets.iOS("13.0")
}

public struct BundleIdGenerator {
    public func generate(name: String) -> String {
        "kr.minsone.\(name)"
    }
    public var defaultDemoAppBundleId: String {
        "kr.minsone.example.demoApp"
    }
}
