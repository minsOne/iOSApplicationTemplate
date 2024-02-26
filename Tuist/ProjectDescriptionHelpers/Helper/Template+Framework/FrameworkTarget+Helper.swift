//
//  FrameworkTarget+Helper.swift
//  ProjectDescriptionHelpers
//
//  Created by minsOne on 2/15/24.
//

import Foundation

// MARK: Helper

extension FrameworkTemplate.Target {
    var frameworkValue: [Framework]? {
        switch self {
        case let .framework(value): value
        default: nil
        }
    }

    var uiValue: [UI]? {
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
    var frameworks: [FrameworkTemplate.Target.Framework] {
        compactMap(\.frameworkValue)
            .flatMap { $0 }
    }

    var uiList: [FrameworkTemplate.Target.UI] {
        compactMap(\.uiValue)
            .flatMap { $0 }
    }

    var hasInternalDTO: Bool {
        contains(where: \.hasInternalDTO)
    }
}

public extension [FrameworkTemplate.Target.Framework] {
    var module: FrameworkTemplate.Target.Framework.MachO? {
        lazy.compactMap(\.module)
            .first
    }

    var hasTesting: Bool {
        lazy.compactMap { $0.hasTesting }
            .first ?? false
    }

    var hasDemoApp: Bool {
        lazy.compactMap { $0.hasDemoApp }
            .first ?? false
    }

    var hasUnitTests: Bool {
        lazy.compactMap { $0.hasUnitTests }
            .first ?? false
    }
}

public extension [FrameworkTemplate.Target.UI] {
    var hasUI: Bool {
        contains(where: \.hasUI)
    }

    var hasUIPreview: Bool {
        contains(where: \.hasPreview)
    }
}
