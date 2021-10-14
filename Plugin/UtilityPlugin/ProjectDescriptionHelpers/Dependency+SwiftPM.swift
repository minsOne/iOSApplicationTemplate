//
//  SwiftPMDependency.swift
//  UtilityPlugin
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
    static let InjectPropertyWrapper = Dep.package(product: "InjectPropertyWrapper")
    static let ReactorKit            = Dep.package(product: "ReactorKit")
    static let RIBs                  = Dep.package(product: "RIBs")
    static let RxCocoa               = Dep.package(product: "RxCocoa")
    static let RxRelay               = Dep.package(product: "RxRelay")
    static let RxSwift               = Dep.package(product: "RxSwift")
    static let Swinject              = Dep.package(product: "Swinject")
}

public extension Package {
    static let Alamofire             = Package.package(url: "https://github.com/Alamofire/Alamofire.git", .branch("master"))
    static let InjectPropertyWrapper = Package.package(url: "https://github.com/egeniq/InjectPropertyWrapper.git", .branch("master"))
    static let ReactorKit            = Package.package(url: "https://github.com/ReactorKit/ReactorKit.git", .branch("master"))
    static let RIBs                  = Package.package(url: "https://github.com/uber/RIBs.git", .branch("master"))
    static let RxSwift               = Package.package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.0.0")
    static let Swinject              = Package.package(url: "https://github.com/Swinject/Swinject.git", .branch("master"))
}


// MARK: - Swift Package Develop Tool

public extension Dep.SwiftPM.DevelopTool {
    static let OHHTTPStubs             = Dep.package(product: "OHHTTPStubs")
    static let OHHTTPStubsSwift        = Dep.package(product: "OHHTTPStubsSwift")
    static let ProxyNetworkStubPackage = Dep.package(product: "ProxyNetworkStubPackage")
}

public extension Package.DevelopTool {
    static let OHHTTPStubs             = Package.package(url: "https://github.com/AliSoftware/OHHTTPStubs.git", .branch("master"))
//    static let ProxyNetworkStubPackage = Package.local(path: .relativeToNetwork("ProxyNetworkStubPackage"))
}


// MARK: - Swift Package User Interface

public extension Dep.SwiftPM.UserInterface {
    static let ResourcePackage = Dep.package(product: "MOResourcePackage")
}

public extension Package.UserInterface {
    static let ResourcePackage = Package.local(path: .relativeToRoot("Projects/DesignSystem/MOResourcePackage"))
}
