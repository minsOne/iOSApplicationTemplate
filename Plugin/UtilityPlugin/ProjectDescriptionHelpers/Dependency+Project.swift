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
        public struct DataRepository {}
        public struct Domain {}
        public struct Feature {}
        public struct Module {}
        public struct Network {} 
        public struct UserInterface {}
    }
}


public extension Dep.Project.Feature {
    static let Features = Dep.feature(name: "Features")
}


public extension Dep.Project.Domain {
    static let Loan     = Dep.domain(name: "FeatureLoanDomain")
    static let Main     = Dep.domain(name: "FeatureMainDomain")
    static let Settings = Dep.domain(name: "FeatureSettingsDomain")
    static let DependencyComponent = Dep.domain(name: "FeatureDomainComponent")
}


public extension Dep.Project.DataRepository {
    static let Loan     = Dep.dataRepository(name: "FeatureLoanDataRepository")
    static let Main     = Dep.dataRepository(name: "FeatureMainDataRepository")
    static let Settings = Dep.dataRepository(name: "FeatureSettingsDataRepository")
    static let DependencyComponent = Dep.dataRepository(name: "FeatureDataRepositoryComponent")
    static let InjectManager = Dep.dataRepository(name: "RepositoryInjectManager")
}


public extension Dep.Project.UserInterface {
    static let Loan         = Dep.userInterface(name: "FeatureLoanUserInterface")
    static let Main         = Dep.userInterface(name: "FeatureMainUserInterface")
    static let Settings     = Dep.userInterface(name: "FeatureSettingsUserInterface")
    static let DesignSystem = Dep.userInterface(name: "DesignSystem")
    static let DependencyComponent = Dep.userInterface(name: "FeatureUserInterfaceComponent")
}


public extension Dep.Project.Module {
    static let AnalyticsKit                          = Dep.module(name: "AnalyticsKit")
    static let CoreKit                               = Dep.module(name: "CoreKit")
    static let DevelopTool                           = Dep.module(name: "DevelopTool")
    static let RxPackage                             = Dep.module(name: "RxPackage")
    static let ThirdPartyDynamicLibraryPluginManager = Dep.module(name: "ThirdPartyDynamicLibraryPluginManager")
    static let ThirdPartyLibraryManager              = Dep.module(name: "ThirdPartyLibraryManager")
    static let UtilityKit                            = Dep.module(name: "UtilityKit")
}

public extension Dep.Project.Network {
    static let APIs   = Dep.network(name: "NetworkAPIs")
    static let APIKit = Dep.network(name: "NetworkAPIKit")
    static let Common = Dep.network(name: "NetworkAPICommon")
    static let Home   = Dep.network(name: "NetworkAPIHome")
    static let Login  = Dep.network(name: "NetworkAPILogin")
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
    static func domain(name: String) -> Self {
        return .project(target: name, path: .relativeToDomain(name))
    }
    static func dataRepository(name: String) -> Self {
        return .project(target: name, path: .relativeToDataRepository(name))
    }
    static func network(name: String) -> Self {
        return .project(target: name, path: .relativeToNetwork(name))
    }   
}
