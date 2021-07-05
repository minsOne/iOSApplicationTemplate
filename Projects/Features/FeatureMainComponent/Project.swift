import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureMainComponent",
                     dependencies: [
                        .Feature.FeaturesComponent,
                        .Feature.Setting,
                     ])
