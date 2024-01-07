//
//  PathExtension.swift
//  LocalPlugin
//
//  Created by minsone on 2021/05/15.
//

import Foundation
import ProjectDescription

public extension ProjectDescription.Path {
    static func relativeToXCConfig(type: AppConfiguration, name: String) -> Self {
        return .relativeToRoot("XCConfig/\(name)/\(type.rawValue).xcconfig")
    }
    static func relativeToModule(_ pathString: String) -> Self {
        return .relativeToRoot("Projects/Modules/\(pathString)")
    }
    static func relativeToFeature(_ pathString: String) -> Self {
        return .relativeToRoot("Projects/Features/\(pathString)")
    }
    static func relativeToUserInterface(_ pathString: String) -> Self {
        return .relativeToRoot("Projects/UserInterface/\(pathString)")
    }
    static func relativeToDomain(_ pathString: String) -> Self {
        return .relativeToRoot("Projects/Domain/\(pathString)")
    }
    static func relativeToDataRepository(_ pathString: String) -> Self {
        return .relativeToRoot("Projects/DataRepository/\(pathString)")
    }
    static func relativeToNetwork(_ pathString: String) -> Self {
        return .relativeToRoot("Projects/Network/\(pathString)")
    }
    static func relativeToCarthage(_ pathString: String) -> Self {
        return .relativeToRoot("Tuist/Dependencies/Carthage/\(pathString)")
    }
    static var app: Self {
        return .relativeToRoot("Projects/App")
    }
}

// MARK: Extension
extension Dep {
    static func module(name: String) -> Self {
        return .project(target: name, path: .relativeToModule(name))
    }
    static func feature(name: String) -> Self {
        return .project(target: name, path: .relativeToFeature(name))
    }
    static func feature(name: String, path: String) -> Self {
        return .project(target: name, path: .relativeToFeature(path))
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
