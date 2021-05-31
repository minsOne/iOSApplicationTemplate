//
//  SwiftPMDependency.swift
//  UtilityPlugin
//
//  Created by minsone on 2021/05/15.
//

import Foundation
import ProjectDescription

// MARK: Package
public extension TargetDependency {
    struct SwiftPM {}
}

public extension TargetDependency.SwiftPM {
    static let Alamofire: TargetDependency = .package(product: "Alamofire")
    static let SnapKit: TargetDependency = .package(product: "SnapKit")
    static let ResourcePackage: TargetDependency = .package(product: "ResourcePackage")
    static let OHHTTPStubs: TargetDependency = .package(product: "OHHTTPStubs")
    static let OHHTTPStubsSwift: TargetDependency = .package(product: "OHHTTPStubsSwift")
    static let FlexLayout: TargetDependency = .package(product: "FlexLayout")
}

public extension Package {
    static let Alamofire: Package = .package(url: "https://github.com/Alamofire/Alamofire.git",
                                             .branch("master"))
    static let SnapKit: Package = .package(url: "https://github.com/SnapKit/SnapKit.git",
                                           .upToNextMajor(from: "5.0.1"))
    static let ResourcePackage: Package = .local(path: .relativeToModule("ResourcePackage"))
    static let OHHTTPStubs: Package = .package(url: "https://github.com/AliSoftware/OHHTTPStubs.git",
                                               .branch("master"))
    static let FlexLayout: Package = .package(url: "https://github.com/layoutBox/FlexLayout.git",
                                              .branch("master"))
}
