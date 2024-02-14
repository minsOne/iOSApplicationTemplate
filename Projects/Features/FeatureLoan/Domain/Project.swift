import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .deprecatedStaticFramework(name: "FeatureLoanDomain",
                     dependencies: [
                        .Project.Feature.BaseDependency.Domain,
                        .Project.Feature.Loan.UserInterface,
                     ])
