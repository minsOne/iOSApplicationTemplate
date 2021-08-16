import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureLoan",
                     dependencies: [
                        .Project.Feature.LoanComponent,
                     ],
                     hasDemoApp: true)
