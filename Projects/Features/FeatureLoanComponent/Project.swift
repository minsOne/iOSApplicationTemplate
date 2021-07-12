import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureLoanComponent",
                     dependencies: [
                        .Feature.FeaturesComponent,
                     ])
