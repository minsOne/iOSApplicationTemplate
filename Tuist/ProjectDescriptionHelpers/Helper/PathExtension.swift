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
        .relativeToRoot("XCConfig/\(name)/\(type.rawValue).xcconfig")
    }

    static func moduleXCConfig(type: AppConfiguration) -> Self {
        .relativeToRoot("XCConfig/Module/\(type.rawValue).xcconfig")
    }

    static func relativeToModule(_ pathString: String) -> Self {
        .relativeToRoot("Projects/Modules/\(pathString)")
    }

    static func relativeToFeature(_ pathString: String) -> Self {
        .relativeToRoot("Projects/Features/\(pathString)")
    }

    static func relativeToUserInterface(_ pathString: String) -> Self {
        .relativeToRoot("Projects/Modules/UI/\(pathString)")
    }

    static func relativeToNetwork(_ pathString: String) -> Self {
        .relativeToRoot("Projects/Modules/Network/\(pathString)")
    }

    static func relativeToCarthage(_ pathString: String) -> Self {
        .relativeToRoot("Carthage/Build/\(pathString)")
    }

    static var app: Self {
        .relativeToRoot("Projects/App")
    }
}

// MARK: Extension

extension Dep {
    static func feature(name: String, path: String? = nil) -> Self {
        .project(target: name, path: .relativeToFeature(path ?? name))
    }

    static func userInterface(name: String) -> Self {
        .project(target: name, path: .relativeToUserInterface(name))
    }

    static func network(name: String) -> Self {
        .project(target: name, path: .relativeToNetwork(name))
    }
}
