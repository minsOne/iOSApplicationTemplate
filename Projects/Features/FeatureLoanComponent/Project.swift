import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureLoanComponent",
                     dependencies: [
                        .Project.Feature.FeaturesComponent,
                        .Project.UserInterface.FeatureLoanUserInterface,
                     ])
