//
//  CarthageDependency.swift
//  UtilityPlugin
//
//  Created by minsone on 2021/05/31.
//

import Foundation
import ProjectDescription

// MARK: Carthage
public extension TargetDependency {
    struct Carthage {}
}

public extension TargetDependency.Carthage {
    static let FLEX: TargetDependency = .carthage(name: "FLEX")
}

public extension TargetDependency {
    static func carthage(name: String) -> Self {
        return .xcFramework(path: .relativeToRoot("Tuist/Dependencies/Carthage/\(name).xcframework"))
    }
}
