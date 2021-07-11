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
        public struct Network {} 
    }
    struct Feature {}
}

public extension TargetDependency.Feature {
    static let Features          = TargetDependency.feature(name: "Features")
    static let FeaturesComponent = TargetDependency.feature(name: "FeaturesComponent")
    static let Main              = TargetDependency.feature(name: "FeatureMain")
    static let MainComponent     = TargetDependency.feature(name: "FeatureMainComponent")
    static let Setting           = TargetDependency.feature(name: "FeatureSetting")
    static let SettingComponent  = TargetDependency.feature(name: "FeatureSettingComponent")
}

public extension TargetDependency.Project {
    static let UtilityKit               = TargetDependency.module(name: "UtilityKit")
    static let NetworkAPIKit            = TargetDependency.module(name: "NetworkAPIKit")
    static let NetworkAPI               = TargetDependency.module(name: "NetworkAPI")
    static let CoreKit                  = TargetDependency.module(name: "CoreKit")
    static let DevelopTool              = TargetDependency.module(name: "DevelopTool")
    static let AnalyticsKit             = TargetDependency.module(name: "AnalyticsKit")
    static let ThirdPartyLibraryManager = TargetDependency.module(name: "ThirdPartyLibraryManager")
    static let ThirdPartyDynamicLibraryPluginManager = TargetDependency.module(name: "ThirdPartyDynamicLibraryPluginManager")
}

public extension TargetDependency.Project.Network {
    static let Common = TargetDependency.module(name: "NetworkAPICommon")
    static let Home   = TargetDependency.module(name: "NetworkAPIHome")
    static let Login  = TargetDependency.module(name: "NetworkAPILogin")
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
