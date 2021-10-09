import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "FeatureMainUserInterface",
                     dependencies: [
                        .Project.Feature.BaseDependency.UserInterface,
                        .Project.UserInterface.DesignSystem,
                     ],
                     hasDemoApp: true)
