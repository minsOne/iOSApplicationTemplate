import Foundation
import ProjectDescription

private typealias Template = MultipleTargetTemplate

public extension Template {
    enum Target: Hashable {
        case multipleTarget
        case unitTest
        case demoApp
    }
}

extension [Template.Target] {
    var hasUnitTest: Bool {
        contains(where: \.hasUnitTest)
    }

    var hasDemoApp: Bool {
        contains(where: \.hasDemoApp)
    }

    var hasMultipleTarget: Bool {
        contains(where: \.hasMultipleTarget)
    }
}

extension Template.Target {
    var hasUnitTest: Bool {
        switch self {
        case .multipleTarget, .demoApp: false
        case .unitTest: true
        }
    }

    var hasDemoApp: Bool {
        switch self {
        case .multipleTarget, .unitTest: false
        case .demoApp: true
        }
    }

    var hasMultipleTarget: Bool {
        switch self {
        case .multipleTarget: true
        case .unitTest, .demoApp: false
        }
    }
}
