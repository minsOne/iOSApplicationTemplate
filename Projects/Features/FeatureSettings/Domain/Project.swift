import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .deprecatedStaticFramework(
        name: "FeatureSettingsDomain",
        dependencies: [
            .Project.Feature.BaseDependency.Domain,
            .Project.Feature.Settings.UserInterface,
        ]
    )
