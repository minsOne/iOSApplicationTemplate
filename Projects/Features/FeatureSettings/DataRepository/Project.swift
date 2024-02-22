import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .deprecatedStaticFramework(
        name: "FeatureSettingsDataRepository",
        dependencies: [
            .Project.Feature.BaseDependency.DataRepository,
            .Project.Feature.Settings.Domain,
        ]
    )
