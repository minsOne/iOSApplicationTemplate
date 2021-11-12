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
            public struct Main {}
            public struct Setting {}
            public struct Loan {}
            public struct BaseDependency {}
        }
        public struct Module {
            public struct Core {
                public struct Network {}
            }
            public struct Foundation {}
        }
        public struct UserInterface {
            public struct DesignSystem {}
        }
        public struct DevelopTool {}
    }
}

// MAKR : Feature
public extension Dep.Project.Feature {
    static func project(name: String) -> Dep { .project(target: name, path: .relativeToRoot("Projects/Features/\(name)")) }

    static let FeatureKit = project(name: "MOFeatureKit")
}

public extension Dep.Project.Feature.Main {
    static let group = "MOFeatureMain"
    static func project(name: String) -> Dep { .project(target: "\(group)\(name)", path: .relativeToRoot("Projects/Features/\(group)/\(name)")) }

    static let Domain        = project(name: "Domain")
    static let Repository    = project(name: "Repository")
    static let UserInterface = project(name: "UserInterface")
}

public extension Dep.Project.Feature.Setting {
    static let group = "MOFeatureSetting"
    static func project(name: String) -> Dep { .project(target: "\(group)\(name)", path: .relativeToRoot("Projects/Features/\(group)/\(name)")) }

    static let Domain        = project(name: "Domain")
    static let Repository    = project(name: "Repository")
    static let UserInterface = project(name: "UserInterface")
}

public extension Dep.Project.Feature.Loan {
    static let group = "MOFeatureLoan"
    static func project(name: String) -> Dep { .project(target: "\(group)\(name)", path: .relativeToRoot("Projects/Features/\(group)/\(name)")) }

    static let Domain        = project(name: "Domain")
    static let Repository    = project(name: "Repository")
    static let UserInterface = project(name: "UserInterface")
}

public extension Dep.Project.Feature.BaseDependency {
    static let group = "MOFeatureBaseDependency"
    static func project(name: String) -> Dep { .project(target: "\(group)\(name)", path: .relativeToRoot("Projects/Features/\(group)/\(name)")) }

    static let Domain        = project(name: "Domain")
    static let Repository    = project(name: "Repository")
    static let UserInterface = project(name: "UserInterface")
}

// MARK: - Module
public extension Dep.Project.Module {
    static func project(name: String) -> Dep { .project(target: name, path: .relativeToRoot("Projects/Modules/\(name)")) }

    static let RxPackage = project(name: "RxPackage")
}

// MARK: - Module / Core
public extension Dep.Project.Module.Core {
    static func project(name: String) -> Dep { .project(target: name, path: .relativeToRoot("Projects/Modules/Core/\(name)")) }

    static let AppLogger            = project(name: "MOAppLogger")
    static let CoreKit              = project(name: "MOCoreKit")
    static let RxPackageExtension   = project(name: "MORxPackageExtension")
    static let ThirdPartyLibManager = project(name: "MOThirdPartyLibManager")
}

// MARK: - Module / Core / Network
public extension Dep.Project.Module.Core.Network {
    static func project(name: String) -> Dep { .project(target: name, path: .relativeToRoot("Projects/Modules/Core/Network/\(name)")) }
    
    static let NetworkAPICommon = project(name: "MONetworkAPICommon")
    static let NetworkAPIHome   = project(name: "MONetworkAPIHome")
    static let NetworkAPIKit    = project(name: "MONetworkAPIKit")
    static let NetworkAPILogin  = project(name: "MONetworkAPILogin")
    static let NetworkAPIs      = project(name: "MONetworkAPIs")
}

// MARK: - Module / Foundation
public extension Dep.Project.Module.Foundation {
    static func project(name: String) -> Dep { .project(target: name, path: .relativeToRoot("Projects/Modules/Foundation/\(name)")) }

    static let FoundationKit = project(name: "MOFoundationKit")
    static let UtilityKit    = project(name: "MOUtilityKit")
}

// MARK: - Module / UserInterface / DesignSystem
public extension Dep.Project.UserInterface.DesignSystem {
    static func project(name: String) -> Dep { .project(target: name, path: .relativeToRoot("Projects/DesignSystem/\(name)")) }

    static let DesignSystemKit = project(name: "MODesignSystemKit")
}

// MARK: - Module / DevelopTool
public extension Dep.Project.DevelopTool {
    static func project(name: String) -> Dep { .project(target: name, path: .relativeToRoot("Projects/DevelopTool/\(name)")) }

    static let ExampleDevToolPackage = project(name: "MOExampleDevToolPackage")
}