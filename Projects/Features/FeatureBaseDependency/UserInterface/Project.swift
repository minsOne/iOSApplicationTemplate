import ProjectDescription
import ProjectDescriptionHelpers

let project = FrameworkTemplate(
    name: "FeatureBaseDependencyUserInterface",
    target: [
        .framework([.module(.static)]),
    ],
    configure: .init(
        framework: .init(dependency: [
            .Project.UserInterface.DesignSystem,
        ])
    )
).project
