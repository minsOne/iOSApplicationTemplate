//
//  PathExtension.swift
//  LocalPlugin
//
//  Created by minsone on 2021/05/15.
//

import Foundation
import ProjectDescription

public extension ProjectDescription.Path {
    static func relativeToXCConfig(type: ProjectDeployTarget, name: String) -> Self {
        return .relativeToRoot("XCConfig/\(name)/\(name)-\(type.rawValue).xcconfig")
    }
    static func relativeToModule(_ pathString: String) -> Self {
        return .relativeToRoot("Projects/Modules/\(pathString)")
    }
    static func relativeToFeature(_ pathString: String) -> Self {
        return .relativeToRoot("Projects/Features/\(pathString)")
    }
    static var app: Self {
        return .relativeToRoot("Projects/App")
    }
}
