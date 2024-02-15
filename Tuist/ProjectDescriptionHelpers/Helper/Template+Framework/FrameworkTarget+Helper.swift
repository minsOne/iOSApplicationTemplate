//
//  FrameworkTarget+Helper.swift
//  ProjectDescriptionHelpers
//
//  Created by minsOne on 2/15/24.
//

import Foundation

// MARK: Helper

extension FrameworkTemplate.Target {
    var frameworkList: [Framework]? {
        switch self {
        case let .framework(value): value
        default: nil
        }
    }

    var uiList: [UI]? {
        switch self {
        case let .ui(value): value
        default: nil
        }
    }

    var hasInternalDTO: Bool {
        switch self {
        case .internalDTO: true
        default: false
        }
    }
}

extension FrameworkTemplate.Target.Framework {
    var module: MachO? {
        switch self {
        case let .module(machO): machO
        default: nil
        }
    }

    var hasTesting: Bool {
        switch self {
        case .testing: true
        default: false
        }
    }

    var hasDemoApp: Bool {
        switch self {
        case .demoApp: true
        default: false
        }
    }

    var hasUnitTests: Bool {
        switch self {
        case .unitTests: true
        default: false
        }
    }
}

extension FrameworkTemplate.Target.UI {
    var hasUI: Bool {
        switch self {
        case .ui: true
        default: false
        }
    }

    var hasPreview: Bool {
        switch self {
        case .preview: true
        default: false
        }
    }
}

public extension [FrameworkTemplate.Target] {
    var module: FrameworkTemplate.Target.Framework.MachO? {
        lazy.compactMap(\.frameworkList)
            .flatMap { $0 }
            .compactMap(\.module)
            .first
    }

    var hasTesting: Bool {
        lazy.compactMap(\.frameworkList)
            .flatMap { $0 }
            .compactMap { $0.hasTesting }
            .first ?? false
    }

    var hasDemoApp: Bool {
        lazy.compactMap(\.frameworkList)
            .flatMap { $0 }
            .compactMap { $0.hasDemoApp }
            .first ?? false
    }

    var hasUnitTests: Bool {
        lazy.compactMap(\.frameworkList)
            .flatMap { $0 }
            .compactMap { $0.hasUnitTests }
            .first ?? false
    }

    var hasUI: Bool {
        lazy.compactMap(\.uiList)
            .flatMap { $0 }
            .compactMap { $0.hasUI }
            .first ?? false
    }

    var hasUIPreview: Bool {
        lazy.compactMap(\.uiList)
            .flatMap { $0 }
            .compactMap { $0.hasPreview }
            .first ?? false
    }

    var hasInternalDTO: Bool {
        lazy.compactMap { $0.hasInternalDTO }
            .first ?? false
    }
}
