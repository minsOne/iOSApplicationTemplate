import Foundation
import ProjectDescription

public extension Dep.Project {
    enum Feature {}
}

public extension Dep.Project.Feature {
    static let Features = Dep.feature(name: "Features")

    enum BaseDependency {
        public static let UserInterface = Dep.feature(name: "FeatureBaseDependencyUserInterface", path: "BaseDependency/UserInterface")
        public static let Domain = Dep.feature(name: "FeatureBaseDependencyDomain", path: "BaseDependency/Domain")
        public static let DataRepository = Dep.feature(name: "FeatureBaseDependencyDataRepository", path: "BaseDependency/DataRepository")
    }
}
