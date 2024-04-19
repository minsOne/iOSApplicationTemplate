import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .deprecatedStaticFramework(
        name: "FeatureLoanUserInterface",
        dependencies: [
            .Project.Feature.BaseDependency.UserInterface,
        ]
    )
