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
        public struct Feature {
            public struct Settings {}
            public struct Main {}
            public struct Loan {}
        }
        public struct Module {}
        public struct Network {} 
        public struct UserInterface {}
    }
}


public extension Dep.Project.Feature {
    static let Features = Dep.feature(name: "Features")

    struct BaseDependency {
        public static let UserInterface  = Dep.feature(name: "FeatureBaseDependencyUserInterface", path: "BaseDependency/UserInterface")
        public static let Domain         = Dep.feature(name: "FeatureBaseDependencyDomain", path: "BaseDependency/Domain")
        public static let DataRepository = Dep.feature(name: "FeatureBaseDependencyDataRepository", path: "BaseDependency/DataRepository")
    }
}

public extension Dep.Project.Feature.Settings {
    static let Pacakge        = Dep.feature(name: "FeatureSettingsPackage", path: "FeatureSettings/Package")
    static let UserInterface  = Dep.feature(name: "FeatureSettingsUserInterface", path: "FeatureSettings/UserInterface")
    static let Domain         = Dep.feature(name: "FeatureSettingsDomain", path: "FeatureSettings/Domain")
    static let DataRepository = Dep.feature(name: "FeatureSettingsDataRepository", path: "FeatureSettings/DataRepository")
}

public extension Dep.Project.Feature.Main {
    static let Pacakge        = Dep.feature(name: "FeatureMainPackage", path: "FeatureMain/Package")
    static let UserInterface  = Dep.feature(name: "FeatureMainUserInterface", path: "FeatureMain/UserInterface")
    static let Domain         = Dep.feature(name: "FeatureMainDomain", path: "FeatureMain/Domain")
    static let DataRepository = Dep.feature(name: "FeatureMainDataRepository", path: "FeatureMain/DataRepository")
}

public extension Dep.Project.Feature.Loan {
    static let Pacakge        = Dep.feature(name: "FeatureLoanPackage", path: "FeatureLoan/Package")
    static let UserInterface  = Dep.feature(name: "FeatureLoanUserInterface", path: "FeatureLoan/UserInterface")
    static let Domain         = Dep.feature(name: "FeatureLoanDomain", path: "FeatureLoan/Domain")
    static let DataRepository = Dep.feature(name: "FeatureLoanDataRepository", path: "FeatureLoan/DataRepository")
}

public extension Dep.Project.UserInterface {
    static let DesignSystem = Dep.userInterface(name: "DesignSystem")
}

public extension Dep.Project.Module {
    static let AnalyticsKit                          = Dep.module(name: "AnalyticsKit")
    static let CoreKit                               = Dep.module(name: "CoreKit")
    static let DevelopTool                           = Dep.module(name: "DevelopTool")
    static let RxPackage                             = Dep.module(name: "RxPackage")
    static let ThirdPartyDynamicLibraryPluginManager = Dep.module(name: "ThirdPartyDynamicLibraryPluginManager")
    static let ThirdPartyLibraryManager              = Dep.module(name: "ThirdPartyLibraryManager")
    static let UtilityKit                            = Dep.module(name: "UtilityKit")
    static let RepositoryInjectManager               = Dep.module(name: "RepositoryInjectManager")
}

public extension Dep.Project.Network {
    static let APIs   = Dep.network(name: "NetworkAPIs")
    static let APIKit = Dep.network(name: "NetworkAPIKit")
    static let Common = Dep.network(name: "NetworkAPICommon")
    static let Home   = Dep.network(name: "NetworkAPIHome")
    static let Login  = Dep.network(name: "NetworkAPILogin")
}




