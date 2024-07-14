//
//  CarthageDependency.swift
//  ProjectDescriptionHelpers
//
//  Created by minsone on 2021/05/31.
//

import Foundation
import ProjectDescription

// MARK: Carthage
public extension Dep {
    struct Carthage {}
}

public extension Dep.Carthage {
}

public extension Dep {
    static func carthage(name: String) -> Self {
        return .xcframework(path: .relativeToCarthage("\(name).xcframework"))
    }
}
