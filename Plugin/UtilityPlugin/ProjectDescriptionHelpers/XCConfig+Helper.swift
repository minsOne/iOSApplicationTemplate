//
//  XCConfig+Helper.swift
//  UtilityPlugin
//
//  Created by minsOne on 1/7/24.
//

import Foundation
import ProjectDescription

public struct XCConfig {}

public extension XCConfig {
    enum Application {
        public static func app(_ configuration: AppConfiguration) -> Path {
            "//XCConfig/App/App-\(configuration.rawValue).xcconfig"
        }

        public static func devApp(_ configuration: AppConfiguration) -> Path {
            "//XCConfig/App/DevApp-\(configuration.rawValue).xcconfig"
        }
    }
}
