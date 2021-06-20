//
//  SwiftPMDependency.swift
//  UtilityPlugin
//
//  Created by minsone on 2021/05/15.
//

import Foundation
import ProjectDescription

// MARK: Package
extension TargetDependency {
    public struct SwiftPM {
        public struct DevelopTool {}
    }
}

extension Package {
    public struct DevelopTool {}
}

public extension TargetDependency.SwiftPM {
    static let Alamofire        = TargetDependency.package(product: "Alamofire")
    static let SnapKit          = TargetDependency.package(product: "SnapKit")
    static let ResourcePackage  = TargetDependency.package(product: "ResourcePackage")
    static let FlexLayout       = TargetDependency.package(product: "FlexLayout")
    static let ReactorKit       = TargetDependency.package(product: "ReactorKit")
    static let RIBs             = TargetDependency.package(product: "RIBs")
    static let RxSwift          = TargetDependency.package(product: "RxSwift")
    static let RxCocoa          = TargetDependency.package(product: "RxCocoa")
    static let RxRelay          = TargetDependency.package(product: "RxRelay")
}

public extension TargetDependency.SwiftPM.DevelopTool {
    static let OHHTTPStubs      = TargetDependency.package(product: "OHHTTPStubs")
    static let OHHTTPStubsSwift = TargetDependency.package(product: "OHHTTPStubsSwift")
    static let NetworkStub = TargetDependency.package(product: "NetworkStub")
}

public extension Package {
    static let Alamofire       = Package.package(url: "https://github.com/Alamofire/Alamofire.git", .branch("master"))
    static let FlexLayout      = Package.package(url: "https://github.com/layoutBox/FlexLayout.git", .branch("master"))
    static let ReactorKit      = Package.package(url: "https://github.com/ReactorKit/ReactorKit.git", .branch("master"))
    static let ResourcePackage = Package.local(path: .relativeToModule("ResourcePackage"))
    static let RIBs            = Package.package(url: "https://github.com/uber/RIBs.git", .branch("master"))
    static let RxSwift         = Package.package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.0.0")
    static let SnapKit         = Package.package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1"))
}

public extension Package.DevelopTool {
    static let NetworkStub = Package.local(path: .relativeToModule("NetworkStub"))
    static let OHHTTPStubs     = Package.package(url: "https://github.com/AliSoftware/OHHTTPStubs.git", .branch("master"))
}