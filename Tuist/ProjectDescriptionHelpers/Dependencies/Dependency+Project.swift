import Foundation
import ProjectDescription

// MARK: Project

public extension Dep {
    enum Project {
        public struct Module {}
        public struct Network {}
        public struct UserInterface {}
    }
}

public extension Dep.Project.UserInterface {
    static let DesignSystem = Dep.userInterface(name: "DesignSystem")
}

public extension Dep.Project.Module {
    static let AnalyticsKit = Dep.module(name: "AnalyticsKit")
    static let CoreKit = Dep.module(name: "CoreKit")
    static let DevelopTool = Dep.module(name: "DevelopTool")
    static let UtilityKit = Dep.module(name: "UtilityKit")
}

public extension Dep.Project.Module {
    private static func project(name: String) -> Dep {
        .module(name: name, path: "LibraryManager/\(name)")
    }

    static let ThirdPartyLibraryManager = project(name: "ThirdPartyLibraryManager")
    static let UIThirdPartyLibraryManager = project(name: "UIThirdPartyLibraryManager")
    static let SharedThirdPartyLibraryManager = project(name: "SharedThirdPartyLibraryManager")
}
