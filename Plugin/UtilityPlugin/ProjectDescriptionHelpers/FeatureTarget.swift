//
//  FeatureTarget.swift
//  UtilityPlugin
//
//  Created by minsone on 2021/10/07.
//

import Foundation

public enum FeatureTarget: Hashable {
    case staticframework
    case dynamicframework
    case tests
    case testing
    case example

    public var hasFramework: Bool {
        switch self {
        case .dynamicframework, .staticframework: return true
        default: return false
        }
    }
    public var hasDynamicFramework: Bool { return self == .dynamicframework }
}
