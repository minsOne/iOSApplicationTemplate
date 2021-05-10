//
//  PathExtension.swift
//  ProjectDescriptionHelpers
//
//  Created by minsone on 2021/05/11.
//

import Foundation
import ProjectDescription

public extension ProjectDescription.Path {
    enum XCConfig: String {
        case dev = "DEV", test = "TEST", stage = "STAGE", prod = "PROD"
    }
}

public extension ProjectDescription.Path {
    static func relativeToXCConfig(type: XCConfig, name: String) -> Self {
        return .relativeToRoot("XCConfig/\(name)/\(name)-\(type.rawValue).xcconfig")
    }
    static func relativeToModule(_ pathString: String) -> Self {
        return .relativeToRoot("Projects/Modules/\(pathString)")
    }
}
