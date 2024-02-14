import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .deprecatedStaticFramework(name: "FeatureLoanDataRepository",
                     dependencies: [
                        .Project.Feature.BaseDependency.DataRepository,
                        .Project.Feature.Loan.Domain,
                     ])
