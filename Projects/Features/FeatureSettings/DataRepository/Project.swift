import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureSettingsDataRepository",
                     dependencies: [
                        .Project.Feature.BaseDependency.DataRepository,
                        .Project.Feature.Settings.Domain,
                     ])
