import ProjectDescription
import ProjectDescriptionHelpers

let project = FrameworkTemplate(
    name: "FeatureSettingsDomain",
    target: [
        .framework([.module(.static)]),
    ],
    configure: .init(
        framework: .init(dependency: [
            .Project.Feature.BaseDependency.Domain,
            .Project.Feature.Settings.UserInterface,
        ])
    )
).project
