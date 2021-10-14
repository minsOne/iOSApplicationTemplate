//
//  CarthageDependency.swift
//  UtilityPlugin
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
    static func carthage(name: String) -> Dep { .project(target: name, path: .relativeToRoot("Tuist/Dependencies/Carthage/\(name)")) }

    static let FLEX               = carthage(name: "FLEX")
    static let Nimble             = carthage(name: "Nimble")
    static let Quick              = carthage(name: "Quick")
    static let RxBlocking         = carthage(name: "RxBlocking")
    static let RxTest             = carthage(name: "RxTest")
    static let RxNimbleRxBlocking = carthage(name: "RxNimbleRxBlocking")
    static let RxNimbleRxTest     = carthage(name: "RxNimbleRxTest")
    static let FlexLayout         = carthage(name: "FlexLayout")
    static let PinLayout          = carthage(name: "PinLayout")
    static let SnapKit            = carthage(name: "SnapKit")
}
