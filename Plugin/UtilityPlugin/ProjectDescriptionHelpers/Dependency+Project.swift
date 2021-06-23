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
    struct Feature {}
}

public extension TargetDependency.Feature {
    static let Features        = TargetDependency.feature(name: "Features")
    static let Main            = TargetDependency.feature(name: "FeatureMain")
    static let SharedComponent = TargetDependency.feature(name: "FeatureSharedComponent")
}

public extension TargetDependency.Project {
    static let UtilityKit               = TargetDependency.module(name: "UtilityKit")
    static let NetworkAPIKit            = TargetDependency.module(name: "NetworkAPIKit")
    static let NetworkAPI               = TargetDependency.module(name: "NetworkAPI")
    static let CoreKit                  = TargetDependency.module(name: "CoreKit")
    static let DevelopTool              = TargetDependency.module(name: "DevelopTool")
    static let AnalyticsKit             = TargetDependency.module(name: "AnalyticsKit")
    static let ThirdPartyLibraryManager = TargetDependency.module(name: "ThirdPartyLibraryManager")
}

// MARK: Extension
public extension TargetDependency {
    static func module(name: String) -> Self {
        return .project(target: name, path: .relativeToModule(name))
    }
    static func feature(name: String) -> Self {
        return .project(target: name, path: .relativeToFeature(name))
    }
}
