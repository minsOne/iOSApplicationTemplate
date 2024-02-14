import Foundation
import ProjectDescription

public enum FrameworkTemplate {}

private typealias Template = FrameworkTemplate

// MARK: Target

public extension Template {
    enum Target: Hashable {
        public enum Framework: Hashable {
            public enum MachO: Hashable {
                case `static`, dynamic
            }

            case module(MachO), testing, demoApp, unitTests
        }

        public enum UI: Hashable {
            case ui, preview
        }

        case framework(Set<Framework>)
        case ui(Set<UI>)
        case internalDTO
    }
}

// MARK: Target Dependency

public extension Template {
    enum Dependency: Hashable {
        case framework([TargetDependency])
        case frameworkDemoApp([TargetDependency])
        case frameworkUnitTests([TargetDependency])
        case ui([TargetDependency])
    }
}

// MARK: Target Configure

public extension Template {
    enum TargetConfigure: Hashable {
        case needResource
        case demoAppIdentifier(String)
    }
}

// MARK: Default Value

public extension Template {
    enum DefaultValue {
        public enum Settings {}
        public enum Plist {}
    }
}

public extension Template.DefaultValue.Settings {
    static let project: SettingsDictionary = [
        "CODE_SIGN_IDENTITY": "",
        "CODE_SIGNING_REQUIRED": "NO"
    ]
}

public extension Template.DefaultValue.Plist {
    static let demoApp: [String: Plist.Value] = [
        "UIMainStoryboardFile": "",
        "UILaunchStoryboardName": "LaunchScreen"
    ]
}
