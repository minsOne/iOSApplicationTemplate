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
    static let FLEX               = Dep.carthage(name: "FLEX")
    static let Nimble             = Dep.carthage(name: "Nimble")
    static let Quick              = Dep.carthage(name: "Quick")
    static let RxBlocking         = Dep.carthage(name: "RxBlocking")
    static let RxTest             = Dep.carthage(name: "RxTest")
    static let RxNimbleRxBlocking = Dep.carthage(name: "RxNimbleRxBlocking")
    static let RxNimbleRxTest     = Dep.carthage(name: "RxNimbleRxTest")
    static let FlexLayout         = Dep.carthage(name: "FlexLayout")
    static let PinLayout          = Dep.carthage(name: "PinLayout")
    static let SnapKit            = Dep.carthage(name: "SnapKit")
}

public extension Dep {
    static func carthage(name: String) -> Self {
        return .xcframework(path: .relativeToCarthage("\(name).xcframework"))
    }
}
