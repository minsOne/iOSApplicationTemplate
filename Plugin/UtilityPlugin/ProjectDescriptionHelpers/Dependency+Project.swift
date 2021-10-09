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
        public struct Feature {}
        public struct Module {
            public struct Core {
                public struct Network {}
            }
            public struct Foundation {}
        }
        public struct UserInterface {}
    }
}

// MARK: - Module / Core
public extension Dep.Project.Module.Core {
    static func project(name: String) -> Dep { .project(target: name, path: .relativeToRoot("Projects/Modules/Core/\(name)")) }

    static let AppLogger            = project(name: "MOAppLogger")
    static let CoreKit              = project(name: "MOCoreKit")
    static let ThirdPartyLibManager = project(name: "MOThirdPartyLibManager")
}

// MARK: - Module / Core / Network
public extension Dep.Project.Module.Core.Network {
    static func project(name: String) -> Dep { .project(target: name, path: .relativeToRoot("Projects/Modules/Core/Network/\(name)")) }
    
    static let NetworkAPIKit = project(name: "MONetworkAPIKit")
    static let NetworkAPIs   = project(name: "MONetworkAPIs")
}

// MARK: - Module / Foundation
public extension Dep.Project.Module.Foundation {
    static func project(name: String) -> Dep { .project(target: name, path: .relativeToRoot("Projects/Modules/Foundation/\(name)")) }

    static let FoundationKit = project(name: "MOFoundationKit")
    static let UtilityKit    = project(name: "MOUtilityKit")
}
