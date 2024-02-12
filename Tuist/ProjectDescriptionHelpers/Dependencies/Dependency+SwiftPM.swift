//
//  SwiftPMDependency.swift
//  ProjectDescriptionHelpers
//
//  Created by minsone on 2021/05/15.
//

import Foundation
import ProjectDescription

// MARK: - Group
extension Dep {
    public struct SwiftPM {
        public struct DevelopTool {}
        public struct UserInterface {}
    }
}
extension Package {
    public struct DevelopTool {}
    public struct UserInterface {}
}


// MARK: - Swift Package

public extension Dep.SwiftPM {
    static let Alamofire             = Dep.package(product: "Alamofire")
}

public extension Package {
    static let Alamofire = Package.package(url: "https://github.com/Alamofire/Alamofire.git", .branch("master"))
    static let DIContainer = Package.package(url: "https://github.com/minsOne/DIContainer.git", .branch("main"))
}


// MARK: - Swift Package Develop Tool

public extension Dep.SwiftPM.DevelopTool {
    static let OHHTTPStubs             = Dep.package(product: "OHHTTPStubs")
    static let OHHTTPStubsSwift        = Dep.package(product: "OHHTTPStubsSwift")
    static let ProxyNetworkStubPackage = Dep.package(product: "ProxyNetworkStubPackage")
}

public extension Package.DevelopTool {
    static let OHHTTPStubs             = Package.package(url: "https://github.com/AliSoftware/OHHTTPStubs.git", .branch("master"))
    static let ProxyNetworkStubPackage = Package.local(path: .relativeToNetwork("ProxyNetworkStubPackage"))
}


// MARK: - Swift Package User Interface

public extension Dep.SwiftPM.UserInterface {
    static let ResourcePackage = Dep.package(product: "ResourcePackage")
}

public extension Package.UserInterface {
    static let ResourcePackage = Package.local(path: .relativeToUserInterface("ResourcePackage"))
}
