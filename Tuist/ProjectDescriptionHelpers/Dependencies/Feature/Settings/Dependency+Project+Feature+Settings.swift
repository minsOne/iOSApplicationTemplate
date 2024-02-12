import Foundation
import ProjectDescription

public extension Dep.Project.Feature {
    enum Settings {}
}

public extension Dep.Project.Feature.Settings {
    static let UserInterface = Dep.feature(name: "FeatureSettingsUserInterface", path: "FeatureSettings/UserInterface")
    static let Domain = Dep.feature(name: "FeatureSettingsDomain", path: "FeatureSettings/Domain")
    static let DataRepository = Dep.feature(name: "FeatureSettingsDataRepository", path: "FeatureSettings/DataRepository")
    static let Pacakge: [Dep] = [UserInterface, Domain, DataRepository]
}
