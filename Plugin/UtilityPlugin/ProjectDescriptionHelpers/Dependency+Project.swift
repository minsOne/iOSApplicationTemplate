//
//  ProjectTargetDependency.swift
//  UtilityPlugin
//
//  Created by minsone on 2021/05/15.
//

import Foundation
import ProjectDescription

// MARK: Project
extension Dep {
    public struct Project {
        public struct Network {} 
        public struct Feature {}
        public struct UserInterface {}
        public struct Module {}
    }
}


public extension Dep.Project.Feature {
    static let Features          = Dep.feature(name: "Features")
    static let FeaturesComponent = Dep.feature(name: "FeaturesComponent")
    static let Main              = Dep.feature(name: "FeatureMain")
    static let MainComponent     = Dep.feature(name: "FeatureMainComponent")
    static let Setting           = Dep.feature(name: "FeatureSetting")
    static let SettingComponent  = Dep.feature(name: "FeatureSettingComponent")
    static let Loan              = Dep.feature(name: "FeatureLoan")
    static let LoanComponent     = Dep.feature(name: "FeatureLoanComponent")
}


public extension Dep.Project.Module {
    static let UtilityKit               = Dep.module(name: "UtilityKit")
    static let NetworkAPIKit            = Dep.module(name: "NetworkAPIKit")
    static let NetworkAPIs              = Dep.module(name: "NetworkAPIs")
    static let CoreKit                  = Dep.module(name: "CoreKit")
    static let DevelopTool              = Dep.module(name: "DevelopTool")
    static let AnalyticsKit             = Dep.module(name: "AnalyticsKit")
    static let RxPackage                = Dep.module(name: "RxPackage")
    static let ThirdPartyLibraryManager = Dep.module(name: "ThirdPartyLibraryManager")
    static let ThirdPartyDynamicLibraryPluginManager = Dep.module(name: "ThirdPartyDynamicLibraryPluginManager")
}


public extension Dep.Project.UserInterface {
    static let DesignSystem = Dep.userInterface(name: "DesignSystem")
    static let FeatureUserInterfaceComponent = Dep.userInterface(name: "FeatureUserInterfaceComponent")
    static let FeatureLoanUserInterface = Dep.userInterface(name: "FeatureLoanUserInterface")
    static let FeatureMainUserInterface = Dep.userInterface(name: "FeatureMainUserInterface")
    static let FeatureSettingsUserInterface = Dep.userInterface(name: "FeatureSettingsUserInterface")
}


public extension Dep.Project.Network {
    static let Common = Dep.module(name: "NetworkAPICommon")
    static let Home   = Dep.module(name: "NetworkAPIHome")
    static let Login  = Dep.module(name: "NetworkAPILogin")
}




// MARK: Extension
extension Dep {
    static func module(name: String) -> Self {
        return .project(target: name, path: .relativeToModule(name))
    }
    static func feature(name: String) -> Self {
        return .project(target: name, path: .relativeToFeature(name))
    }
    static func userInterface(name: String) -> Self {
        return .project(target: name, path: .relativeToUserInterface(name))
    }
}
