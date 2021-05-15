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
    struct SwiftPM {
        public static
        let alamofire: TargetDependency = .package(product: "Alamofire")
        public static
        let snapKit: TargetDependency = .package(product: "SnapKit")
    }
}

public extension Package {
    static let alamofire: Package = .package(url: "https://github.com/Alamofire/Alamofire.git", .branch("master"))
    static let snapKit: Package = .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
}
