import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .deprecatedStaticFramework(
        name: "FeatureMainUserInterface",
        dependencies: [
            .Project.Feature.BaseDependency.UserInterface,
            .Project.UserInterface.DesignSystem,
        ],
        hasDemoApp: true
    )
