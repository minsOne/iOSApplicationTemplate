//
//  CarthageDependency.swift
//  ProjectDescriptionHelpers
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
    static let FLEX       = Dep.carthage(name: "FLEX")
    static let FlexLayout = Dep.carthage(name: "FlexLayout")
    static let Nimble     = Dep.carthage(name: "Nimble")
    static let PinLayout  = Dep.carthage(name: "PinLayout")
    static let Quick      = Dep.carthage(name: "Quick")
    static let RIBs       = Dep.carthage(name: "RIBs")
    static let RxBlocking = Dep.carthage(name: "RxBlocking")
    static let RxCocoa    = Dep.carthage(name: "RxCocoa")
    static let RxRelay    = Dep.carthage(name: "RxRelay")
    static let RxSwift    = Dep.carthage(name: "RxSwift")
    static let RxTest     = Dep.carthage(name: "RxTest")
    static let SnapKit    = Dep.carthage(name: "SnapKit")
}

public extension Dep {
    static func carthage(name: String) -> Self {
        return .xcframework(path: .relativeToCarthage("\(name).xcframework"))
    }
}
