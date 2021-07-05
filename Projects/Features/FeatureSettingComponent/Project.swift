import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureSettingComponent",
                     dependencies: [
                        .Feature.FeaturesComponent,
                     ])
