import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureLoan",
                     dependencies: [
                        .Feature.LoanComponent,
                     ],
                     hasDemoApp: true)
