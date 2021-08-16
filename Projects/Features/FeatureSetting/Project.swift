import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureSetting",
                     dependencies: [
                        .Project.Feature.SettingComponent,
                     ])
