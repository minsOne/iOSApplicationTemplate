import Foundation
import ProjectDescription

// MARK: Project
extension Dep {
    public struct Project {
        public struct Module {}
        public struct Network {} 
        public struct UserInterface {}
    }
}


public extension Dep.Project.UserInterface {
    static let DesignSystem = Dep.userInterface(name: "DesignSystem")
}

public extension Dep.Project.Module {
    static let AnalyticsKit                          = Dep.module(name: "AnalyticsKit")
    static let CoreKit                               = Dep.module(name: "CoreKit")
    static let DevelopTool                           = Dep.module(name: "DevelopTool")
    static let RxPackage                             = Dep.module(name: "RxPackage")
    static let ThirdPartyDynamicLibraryPluginManager = Dep.module(name: "ThirdPartyDynamicLibraryPluginManager")
    static let ThirdPartyLibraryManager              = Dep.module(name: "ThirdPartyLibraryManager")
    static let UtilityKit                            = Dep.module(name: "UtilityKit")
}



