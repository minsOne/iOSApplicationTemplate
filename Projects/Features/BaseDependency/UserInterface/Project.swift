import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .deprecatedStaticFramework(
        name: "FeatureBaseDependencyUserInterface",
        dependencies: [
            .Project.UserInterface.DesignSystem,
        ],
        hasDemoApp: true
    )
