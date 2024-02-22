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
        return .relativeToRoot("Projects/Modules/UI/\(pathString)")
    }

    static func relativeToNetwork(_ pathString: String) -> Self {
        return .relativeToRoot("Projects/Modules/Network/\(pathString)")
    }

    static func relativeToCarthage(_ pathString: String) -> Self {
        return .relativeToRoot("Carthage/Build/\(pathString)")
    }

    static var app: Self {
        return .relativeToRoot("Projects/App")
    }
}

// MARK: Extension

extension Dep {
    static func module(name: String, path: String? = nil) -> Self {
        return .project(target: name, path: .relativeToModule(path ?? name))
    }

    static func feature(name: String, path: String? = nil) -> Self {
        return .project(target: name, path: .relativeToFeature(path ?? name))
    }

    static func userInterface(name: String) -> Self {
        return .project(target: name, path: .relativeToUserInterface(name))
    }

    static func network(name: String) -> Self {
        return .project(target: name, path: .relativeToNetwork(name))
    }
}
