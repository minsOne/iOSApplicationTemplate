//
//  TargetDependencyExtension.swift
//  ProjectDescriptionHelpers
//
//  Created by minsone on 2021/05/10.
//

import ProjectDescription

// MARK: Project
public extension TargetDependency {
    static let utilityKit: TargetDependency = .module(name: "UtilityKit")
    static let networkAPIKit: TargetDependency = .module(name: "NetworkAPIKit")
    static let networkAPI: TargetDependency = .module(name: "NetworkAPI")
    static let coreKit: TargetDependency = .module(name: "CoreKit")
}

// MARK: Package
public extension TargetDependency {
    // TargetDependency에서 외부 SwiftPackage는 다음과 같이 정의함.
    //    static let alamofire: TargetDependency = .package(product: "Alamofire")
    //    static let kingfisher: TargetDependency = .package(product: "Kingfisher")
}

public extension Package {
    // Swift Pacakge는 다음과 같이 정의함.
    //    static let alamofire: Package = .package(url: "https://github.com/Alamofire/Alamofire.git", .branch("master"))
    //    static let kingfisher: Package = .package(url: "https://github.com/onevcat/Kingfisher", from: "5.1.0")
}

public extension TargetDependency {
    static func module(name: String) -> Self {
        return .project(target: name, path: .relativeToModule(name))
    }
}
