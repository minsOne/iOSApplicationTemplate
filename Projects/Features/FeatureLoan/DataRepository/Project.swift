import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureLoanDataRepository",
                     dependencies: [
                        .Project.Feature.BaseDependency.DataRepository,
                        .Project.Feature.Loan.Domain,
                     ])
