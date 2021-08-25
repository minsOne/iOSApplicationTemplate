import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureLoanPackage",
                     dependencies: [
                        .Project.Feature.Loan.DataRepository,
                        .Project.Feature.Loan.Domain,
                        .Project.Feature.Loan.UserInterface,
                     ])
