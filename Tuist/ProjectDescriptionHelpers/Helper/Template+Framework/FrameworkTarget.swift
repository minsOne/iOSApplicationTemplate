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

        case framework([Framework])
        case ui([UI])
        case internalDTO
    }
}

// MARK: Target Configure

public extension Template {
    struct TargetConfigure {
        public struct Framework {
            public struct Module {
                public let isHiddenScheme: Bool

                public init(isHiddenScheme: Bool = false) {
                    self.isHiddenScheme = isHiddenScheme
                }
            }

            public struct Testing {
                public let dependency: [TargetDependency]

                public init(dependency: [TargetDependency] = []) {
                    self.dependency = dependency
                }
            }

            public struct DemoApp {
                public let bundleId: String?
                public let dependency: [TargetDependency]

                public init(bundleId: String? = nil,
                            dependency: [TargetDependency] = []) {
                    self.bundleId = bundleId
                    self.dependency = dependency
                }
            }

            public struct UnitTests {
                public let dependency: [TargetDependency]

                public init(dependency: [TargetDependency] = []) {
                    self.dependency = dependency
                }
            }

            public let module: Module
            public let testing: Testing
            public let demoApp: DemoApp
            public let unitTests: UnitTests

            public init(module: Module = .init(),
                        testing: Testing = .init(),
                        demoApp: DemoApp = .init(),
                        unitTests: UnitTests = .init()) {
                self.module = module
                self.testing = testing
                self.demoApp = demoApp
                self.unitTests = unitTests
            }
        }

        public struct UI {
            public struct UIModule {
                public init() {}
            }

            public struct Preview {
                public let dependency: [TargetDependency]
                public init(dependency: [TargetDependency] = []) {
                    self.dependency = dependency
                }
            }

            public let ui: UIModule
            public let preview: Preview

            public init(ui: UIModule = .init(),
                        preview: Preview = .init()) {
                self.ui = ui
                self.preview = preview
            }
        }

        public struct InternalDTO {
            public let needsMacros: Bool

            public init(needsMacros: Bool = false) {
                self.needsMacros = needsMacros
            }
        }

        public let framework: Framework
        public let ui: UI
        public let internalDTO: InternalDTO
        public let packageName: String?

        public init(framework: Framework = .init(),
                    ui: UI = .init(),
                    internalDTO: InternalDTO = .init(),
                    packageName: PackageName? = nil) {
            self.framework = framework
            self.ui = ui
            self.internalDTO = internalDTO
            self.packageName = packageName?.name
        }
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
        "CODE_SIGNING_REQUIRED": "NO",
    ]
}

public extension Template.DefaultValue.Plist {
    static let demoApp: [String: Plist.Value] = [
        "UIMainStoryboardFile": "",
        "UILaunchStoryboardName": "LaunchScreen",
    ]
}
