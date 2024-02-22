import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .deprecatedStaticFramework(
        name: "FeatureMainDomain",
        dependencies: [
            .Project.Feature.BaseDependency.Domain,
            .Project.Feature.Main.UserInterface,
        ]
    )
