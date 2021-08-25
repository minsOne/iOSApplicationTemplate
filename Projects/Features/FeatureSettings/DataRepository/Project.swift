import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureSettingsDataRepository",
                     dependencies: [
                        .Project.DataRepository.DependencyComponent,
                        .Project.Feature.Settings.Domain,
                     ])
