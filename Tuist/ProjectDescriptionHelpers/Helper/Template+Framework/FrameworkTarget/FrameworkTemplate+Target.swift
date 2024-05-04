import Foundation
import ProjectDescription

private typealias Template = FrameworkTemplate

// MARK: Target

public extension Template {
    enum Target: Hashable {
        case framework([Framework])
        case ui([UI])
        case internalDTO
    }
}

public extension Template.Target {
    enum Framework: Hashable {
        public enum MachO: Hashable {
            case `static`, dynamic
        }

        case module(MachO), testing, demoApp, unitTests, widgetExtension
    }

    enum UI: Hashable {
        case ui, preview, previewApp
    }
}

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
        self == .internalDTO
    }
}
