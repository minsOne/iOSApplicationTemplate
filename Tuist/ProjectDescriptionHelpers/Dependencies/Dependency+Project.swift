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
    private static func project(name: String) -> Dep {
        .project(target: name, path: "//Projects/Modules/\(name)")
    }

    static let AnalyticsKit = project(name: "AnalyticsKit")
    static let DevelopTool = project(name: "DevelopTool")
}

public extension Dep.Project.Module.Foundation {
    private static func project(name: String) -> Dep {
        .project(target: name, path: "//Projects/Modules/Foundation/\(name)")
    }

    static let FoundationKit = project(name: "MOFoundationKit")
    static let Container = project(name: "MOContainer")
}

public extension Dep.Project.Module {
    private static func libraryProject(name: String) -> Dep {
        .project(target: name, path: "//Projects/Modules/LibraryManager/\(name)")
    }

    static let ThirdPartyLibraryManager = project(name: "ThirdPartyLibraryManager")
    static let UIThirdPartyLibraryManager = project(name: "UIThirdPartyLibraryManager")
    static let SharedThirdPartyLibraryManager = project(name: "SharedThirdPartyLibraryManager")
}
