import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureLoanDomain",
                     dependencies: [
                        .Project.Feature.BaseDependency.Domain,
                        .Project.Feature.Loan.UserInterface,
                     ])
