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
    struct Project {
        public static
        let utilityKit: TargetDependency = .module(name: "UtilityKit")
        public static
        let networkAPIKit: TargetDependency = .module(name: "NetworkAPIKit")
        public static
        let networkAPI: TargetDependency = .module(name: "NetworkAPI")
        public static
        let coreKit: TargetDependency = .module(name: "CoreKit")
        public static
        let swiftPackageMerge: TargetDependency = .module(name: "SwiftPackageMerge")
    }
}

public extension TargetDependency {
    static func module(name: String) -> Self {
        return .project(target: name, path: .relativeToModule(name))
    }
}
