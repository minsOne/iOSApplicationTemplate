import Foundation
import ProjectDescription

public extension Dep.Project.Feature {
    enum Main {}
}

public extension Dep.Project.Feature.Main {
    static let UserInterface = Dep.feature(name: "FeatureMainUserInterface", path: "Main/FeatureMain/UserInterface")
    static let Domain = Dep.feature(name: "FeatureMainDomain", path: "Main/FeatureMain/Domain")
    static let DataRepository = Dep.feature(name: "FeatureMainDataRepository", path: "Main/FeatureMain/DataRepository")
    static let Pacakge: [Dep] = [UserInterface, Domain, DataRepository]
}
