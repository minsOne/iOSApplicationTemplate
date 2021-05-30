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
    static let alamofire: TargetDependency = .package(product: "Alamofire")
    static let snapKit: TargetDependency = .package(product: "SnapKit")
    static let resourcePackage: TargetDependency = .package(product: "ResourcePackage")
    static let ohttpStubs: TargetDependency = .package(product: "OHHTTPStubs")
//    static let flex: TargetDependency = .package(product: "FLEX")
    
}

public extension Package {
    static let alamofire: Package = .package(url: "https://github.com/Alamofire/Alamofire.git",
                                             .branch("master"))
    static let snapKit: Package = .package(url: "https://github.com/SnapKit/SnapKit.git",
                                           .upToNextMajor(from: "5.0.1"))
    static let resourcePackage: Package = .local(path: .relativeToModule("ResourcePackage"))
    static let ohttpStubs: Package = .package(url: "https://github.com/AliSoftware/OHHTTPStubs.git",
                                             .branch("master"))
//    static let flex: Package = .package(url: "https://github.com/minsone-opensource-fork/FLEX.git",
//                                        .branch("feature/spm"))
}
