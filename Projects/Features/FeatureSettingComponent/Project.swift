import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureSettingComponent",
                     dependencies: [
                        .Project.Feature.FeaturesComponent,
                        .Project.UserInterface.FeatureSettingsUserInterface,
                     ])
