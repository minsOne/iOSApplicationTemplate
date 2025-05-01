import Foundation
import ProjectDescription

private typealias Template = FrameworkTemplate

public extension Template {
    struct TargetConfigure {
        public let interface: Interface
        public let framework: Framework
        public let ui: UI
        public let internalDTO: InternalDTO
        public let testing: Testing
        public let demoApp: DemoApp
        public let unitTests: UnitTests
        public let preview: Preview
        public let previewApp: PreviewApp
        public let mock: Mock
        public let packageName: String?
        
        public init(interface: Interface = .init(),
                    framework: Framework = .init(),
                    ui: UI = .init(),
                    internalDTO: InternalDTO = .init(),
                    testing: Testing = .init(),
                    demoApp: DemoApp = .init(),
                    unitTests: UnitTests = .init(),
                    preview: Preview = .init(),
                    previewApp: PreviewApp = .init(),
                    mock: Mock = .init(),
                    packageName: PackageName? = nil)
        {
            self.interface = interface
            self.framework = framework
            self.ui = ui
            self.internalDTO = internalDTO
            self.testing = testing
            self.demoApp = demoApp
            self.unitTests = unitTests
            self.preview = preview
            self.previewApp = previewApp
            self.mock = mock
            self.packageName = packageName?.name
        }
    }
}

public extension Template.TargetConfigure {
    struct Interface {
        public let isHiddenScheme: Bool
        public let dependency: [TargetDependency]

        public init(isHiddenScheme: Bool = true,
                    dependency: [TargetDependency] = [])
        {
            self.isHiddenScheme = isHiddenScheme
            self.dependency = dependency
        }
    }
}

public extension Template.TargetConfigure {
    struct Framework {
        public let isHiddenScheme: Bool
        public let bundleId: String?
        public let dependency: [TargetDependency]
        public let needResources: Bool

        public init(isHiddenScheme: Bool = false,
                    bundleId: String? = nil,
                    dependency: [TargetDependency] = [],
                    needResources: Bool = false)
        {
            self.isHiddenScheme = isHiddenScheme
            self.bundleId = bundleId
            self.dependency = dependency
            self.needResources = needResources
        }
    }

    struct Testing {
        public let dependency: [TargetDependency]

        public init(dependency: [TargetDependency] = []) {
            self.dependency = dependency
        }
    }

    struct DemoApp {
        public let bundleId: String?
        public let dependency: [TargetDependency]

        public init(bundleId: String? = nil,
                    dependency: [TargetDependency] = [])
        {
            self.bundleId = bundleId
            self.dependency = dependency
        }
    }

    struct UnitTests {
        public let dependency: [TargetDependency]

        public init(dependency: [TargetDependency] = []) {
            self.dependency = dependency
        }
    }
}

public extension Template.TargetConfigure {
    struct UI {
        public let dependency: [TargetDependency]

        public init(dependency: [TargetDependency] = []) {
            self.dependency = dependency
        }
    }

    struct Preview {
        public let dependency: [TargetDependency]

        public init(dependency: [TargetDependency] = []) {
            self.dependency = dependency
        }
    }

    struct PreviewApp {
        public let dependency: [TargetDependency]

        public init(dependency: [TargetDependency] = []) {
            self.dependency = dependency
        }
    }
}

public extension Template.TargetConfigure {
    struct InternalDTO {
        public let needsMacros: Bool

        public init(needsMacros: Bool = false) {
            self.needsMacros = needsMacros
        }
    }
}

public extension Template.TargetConfigure {
    struct Mock {
        public let dependency: [TargetDependency]

        public init(dependency: [TargetDependency] = []) {
            self.dependency = dependency
        }
    }
}
