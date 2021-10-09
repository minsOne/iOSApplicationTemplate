import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureSettingsDomain",
                     dependencies: [
                        .Project.Feature.BaseDependency.Domain,
                        .Project.Feature.Settings.UserInterface,
                     ])
