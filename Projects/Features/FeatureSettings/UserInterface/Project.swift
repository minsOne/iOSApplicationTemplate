import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .deprecatedStaticFramework(name: "FeatureSettingsUserInterface",
                     dependencies: [
                        .Project.Feature.BaseDependency.UserInterface,
                     ],
                     hasDemoApp: true)
