//
//  StringExtension.swift
//  UtilityPlugin
//
//  Created by minsone on 2021/05/31.
//

import Foundation
import ProjectDescription

// MARK: - Util

public extension String {
    static var dev: String { ProjectDeployTarget.dev.rawValue }
    static var test: String { ProjectDeployTarget.test.rawValue }
    static var stage: String { ProjectDeployTarget.stage.rawValue }
    static var prod: String { ProjectDeployTarget.prod.rawValue }
}

public extension ConfigurationName {
    static var dev: Self { .configuration(.dev) }
    static var test: Self { .configuration(.test) }
    static var stage: Self { .configuration(.stage) }
    static var prod: Self { .configuration(.prod) }
}
