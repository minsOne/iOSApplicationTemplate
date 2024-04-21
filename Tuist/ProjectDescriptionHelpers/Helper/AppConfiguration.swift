import Foundation
import ProjectDescription

public enum AppConfiguration: String {
    case dev = "DEV"
    case test = "TEST"
    case qa = "QA"
    case stage = "STAGE"
    case prod = "PROD"

    public var configurationName: ConfigurationName {
        .configuration(rawValue)
    }
}

public extension String {
    enum Configure {
        static var dev: String { AppConfiguration.dev.rawValue }
        static var test: String { AppConfiguration.test.rawValue }
        static var qa: String { AppConfiguration.qa.rawValue }
        static var stage: String { AppConfiguration.stage.rawValue }
        static var prod: String { AppConfiguration.prod.rawValue }
    }
}

public extension ConfigurationName {
    static var dev: Self { AppConfiguration.dev.configurationName }
    static var test: Self { AppConfiguration.test.configurationName }
    static var qa: Self { AppConfiguration.qa.configurationName }
    static var stage: Self { AppConfiguration.stage.configurationName }
    static var prod: Self { AppConfiguration.prod.configurationName }
}

public struct BundleIdGenerator {
    public func generate(name: String) -> String {
        "kr.minsone.\(name)"
    }
}
