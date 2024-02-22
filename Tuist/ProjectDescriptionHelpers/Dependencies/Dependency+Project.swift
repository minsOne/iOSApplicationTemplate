import Foundation
import ProjectDescription

// MARK: Project

public extension Dep {
    enum Project {
        public enum Module {
            public enum Foundation {}
        }

        public enum Network {}
        public enum UserInterface {}
    }
}

public extension Dep.Project.UserInterface {
    static let DesignSystem = Dep.userInterface(name: "DesignSystem")
}

public extension Dep.Project.Module {
    static let AnalyticsKit = Dep.module(name: "AnalyticsKit")
    static let DevelopTool = Dep.module(name: "DevelopTool")
}

public extension Dep.Project.Module.Foundation {
    static let FoundationKit = Dep.module(name: "MOFoundationKit", path: "Foundation/MOFoundationKit")
    static let Container = Dep.module(name: "MOContainer", path: "Foundation/MOContainer")
}

public extension Dep.Project.Module {
    private static func project(name: String) -> Dep {
        .module(name: name, path: "LibraryManager/\(name)")
    }

    static let ThirdPartyLibraryManager = project(name: "ThirdPartyLibraryManager")
    static let UIThirdPartyLibraryManager = project(name: "UIThirdPartyLibraryManager")
    static let SharedThirdPartyLibraryManager = project(name: "SharedThirdPartyLibraryManager")
}
