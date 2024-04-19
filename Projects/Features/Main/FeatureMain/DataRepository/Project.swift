import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .deprecatedStaticFramework(
        name: "FeatureMainDataRepository",
        dependencies: [
            .Project.Feature.BaseDependency.DataRepository,
            .Project.Feature.Main.Domain,
        ]
    )
