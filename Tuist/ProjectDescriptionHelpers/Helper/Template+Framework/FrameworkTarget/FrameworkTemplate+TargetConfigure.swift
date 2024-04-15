import Foundation
import ProjectDescription

private typealias Template = FrameworkTemplate

public extension Template {
    struct TargetConfigure {
        public let framework: Framework
        public let ui: UI
        public let internalDTO: InternalDTO
        public let packageName: String?

        public init(framework: Framework = .init(),
                    ui: UI = .init(),
                    internalDTO: InternalDTO = .init(),
                    packageName: PackageName? = nil)
        {
            self.framework = framework
            self.ui = ui
            self.internalDTO = internalDTO
            self.packageName = packageName?.name
        }
    }
}

public extension Template.TargetConfigure {
    struct Framework {
        public struct Module {
            public let isHiddenScheme: Bool
            public let needResources: Bool

            public init(isHiddenScheme: Bool = false,
                        needResources: Bool = false)
            {
                self.isHiddenScheme = isHiddenScheme
                self.needResources = needResources
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
                        dependency: [TargetDependency] = [])
            {
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
                    unitTests: UnitTests = .init())
        {
            self.module = module
            self.testing = testing
            self.demoApp = demoApp
            self.unitTests = unitTests
        }
    }

    struct UI {
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
                    preview: Preview = .init())
        {
            self.ui = ui
            self.preview = preview
        }
    }

    struct InternalDTO {
        public let needsMacros: Bool

        public init(needsMacros: Bool = false) {
            self.needsMacros = needsMacros
        }
    }
}
