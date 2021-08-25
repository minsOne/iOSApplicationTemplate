import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureSettingsDomain",
                     dependencies: [
                        .Project.Domain.DependencyComponent,
                        .Project.Feature.Settings.UserInterface,
                     ])
