import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureSettingsPackage",
                     dependencies: [
                        .Project.Feature.Settings.DataRepository,
                        .Project.Feature.Settings.Domain,
                        .Project.Feature.Settings.UserInterface,
                     ])
