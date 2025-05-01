import ProjectDescription
import ProjectDescriptionHelpers

let project = FrameworkTemplate(
    name: "FeatureLoanDomain",
    target: [
        .framework([.module(.static)]),
    ],
    configure: .init(
        framework: .init(dependency: [
            .Project.Feature.BaseDependency.Domain,
            .Project.Feature.Loan.UserInterface,
        ])
    )
).project
