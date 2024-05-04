//
//  FrameworkTemplate+Target+Helper.swift
//  ProjectDescriptionHelpers
//
//  Created by minsOne on 4/15/24.
//

import Foundation

// MARK: Helper

extension FrameworkTemplate.Target.Framework {
    var module: MachO? {
        switch self {
        case let .module(machO): machO
        default: nil
        }
    }

    var hasTesting: Bool {
        self == .testing
    }

    var hasDemoApp: Bool {
        self == .demoApp
    }

    var hasUnitTests: Bool {
        self == .unitTests
    }

    var hasWidgetExtension: Bool {
        self == .widgetExtension
    }
}

extension FrameworkTemplate.Target.UI {
    var hasUI: Bool {
        self == .ui
    }

    var hasPreview: Bool {
        self == .preview
    }
    
    var hasPreviewApp: Bool {
        self == .previewApp
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
        contains(where: \.hasTesting)
    }

    var hasDemoApp: Bool {
        contains(where: \.hasDemoApp)
    }

    var hasUnitTests: Bool {
        contains(where: \.hasUnitTests)
    }

    var hasWidgetExtension: Bool {
        contains(where: \.hasWidgetExtension)
    }
}

public extension [FrameworkTemplate.Target.UI] {
    var hasUI: Bool {
        contains(where: \.hasUI)
    }

    var hasUIPreview: Bool {
        contains(where: \.hasPreview)
    }
    
    var hasUIPreviewApp: Bool {
        contains(where: \.hasPreviewApp)
    }
}
