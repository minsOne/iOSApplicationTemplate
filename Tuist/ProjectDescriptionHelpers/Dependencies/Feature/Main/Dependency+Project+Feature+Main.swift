import Foundation
import ProjectDescription

public extension Dep.Project.Feature {
    enum Main {}
}

public extension Dep.Project.Feature.Main {
    static let UserInterface = Dep.feature(name: "FeatureMainUserInterface", path: "FeatureMain/UserInterface")
    static let Domain = Dep.feature(name: "FeatureMainDomain", path: "FeatureMain/Domain")
    static let DataRepository = Dep.feature(name: "FeatureMainDataRepository", path: "FeatureMain/DataRepository")
    static let Pacakge: [Dep] = [UserInterface, Domain, DataRepository]
}
