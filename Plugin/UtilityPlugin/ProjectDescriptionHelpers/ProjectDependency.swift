//
//  ProjectTargetDependency.swift
//  UtilityPlugin
//
//  Created by minsone on 2021/05/15.
//

import Foundation
import ProjectDescription

// MARK: Project
public extension TargetDependency {
    struct Project {}
}

public extension TargetDependency.Project {
    static let utilityKit: TargetDependency = .module(name: "UtilityKit")
    static let networkAPIKit: TargetDependency = .module(name: "NetworkAPIKit")
    static let networkAPI: TargetDependency = .module(name: "NetworkAPI")
    static let coreKit: TargetDependency = .module(name: "CoreKit")
    static let swiftPackageMerge: TargetDependency = .module(name: "SwiftPackageMerge")
    static let resourceManager: TargetDependency = .module(name: "ResourceManager")
}


// MARK: Extension
public extension TargetDependency {
    static func module(name: String) -> Self {
        return .project(target: name, path: .relativeToModule(name))
    }
}
