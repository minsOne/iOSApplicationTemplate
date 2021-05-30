//
//  StringExtension.swift
//  UtilityPlugin
//
//  Created by minsone on 2021/05/31.
//

import Foundation

// MARK: - Util
public extension String {
    static var dev: String    { ProjectDeployTarget.dev.rawValue }
    static var test: String   { ProjectDeployTarget.test.rawValue }
    static var stage: String  { ProjectDeployTarget.stage.rawValue }
    static var prod: String   { ProjectDeployTarget.prod.rawValue }
}
