import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureMainComponent",
                     dependencies: [
                        .Project.Feature.FeaturesComponent,
                        .Project.Feature.Setting,
                        .Project.Feature.Loan,
                        .Project.UserInterface.FeatureMainUserInterface,
                     ])
