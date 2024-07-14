//
//  SwiftPMDependency.swift
//  ProjectDescriptionHelpers
//
//  Created by minsone on 2021/05/15.
//

import Foundation
import ProjectDescription

// MARK: - Group

public extension Dep {
    enum SwiftPM {
        public enum DevelopTool {}
        public enum UserInterface {}
        public enum Test {}
    }
}

public extension Package {
    enum DevelopTool {}
    enum UserInterface {}
    enum Test {}
}

// MARK: - Swift Package

public extension Dep.SwiftPM {
    static let Alamofire = Dep.package(product: "Alamofire")
    static let DIContainer = Dep.package(product: "DIContainer")
    static let FlexLayout = Dep.package(product: "FlexLayout")
    static let PinLayout = Dep.package(product: "PinLayout")
    static let RxSwift = Dep.package(product: "RxSwift")
    static let RIBs = Dep.package(product: "RIBs")
    static let SnapKit = Dep.package(product: "SnapKit")
}

public extension Package {
    static let Alamofire = Package.package(url: "https://github.com/Alamofire/Alamofire.git", .branch("master"))
    static let DIContainer = Package.package(url: "https://github.com/minsOne/DIContainer.git", .branch("main"))
    static let FlexLayout = Package.package(url: "https://github.com/layoutBox/FlexLayout.git", .branch("master"))
    static let PinLayout = Package.package(url: "https://github.com/layoutBox/PinLayout.git", .branch("master"))
    static let RIBs = Package.package(url: "https://github.com/uber/RIBs.git", .branch("main"))
    static let SnapKit = Package.package(url: "https://github.com/SnapKit/SnapKit.git", .branch("main"))
}

// MARK: - Swift Package Develop Tool

public extension Dep.SwiftPM.DevelopTool {
    static let OHHTTPStubs = Dep.package(product: "OHHTTPStubs")
    static let OHHTTPStubsSwift = Dep.package(product: "OHHTTPStubsSwift")
    static let ProxyNetworkStubPackage = Dep.package(product: "ProxyNetworkStubPackage")
    static let FLEX = Dep.package(product: "FLEX")
}

public extension Package.DevelopTool {
    static let OHHTTPStubs = Package.package(url: "https://github.com/AliSoftware/OHHTTPStubs.git", .branch("master"))
    static let ProxyNetworkStubPackage = Package.local(path: .relativeToRoot("Projects/SwiftPackage/Network/ProxyNetworkStubPackage"))
    static let FLEX = Package.package(url: "https://github.com/FLEXTool/FLEX.git", .branch("master"))
}

// MARK: - Swift Package User Interface

public extension Dep.SwiftPM.UserInterface {
    static let ResourcePackage = Dep.package(product: "ResourcePackage")
}

public extension Package.UserInterface {
    static let ResourcePackage = Package.local(path: .relativeToRoot("Projects/SwiftPackage/UI/ResourcePackage"))
}

// MARK: - Swift Package Test

public extension Dep.SwiftPM.Test {
    static let Stub = Dep.package(product: "MockingKit")
}

public extension Package.Test {
    static let MockingKit = Package.package(url: "https://github.com/tokijh/Stub.git", .branch("main"))
}
