import ProjectDescription
import ProjectDescriptionHelpers

let project = FrameworkTemplate(
    name: "FeatureSettingsDataRepository",
    target: [
        .framework([.module(.static)]),
    ],
    configure: .init(
        framework: .init(dependency: [
            .Project.Feature.BaseDependency.DataRepository,
            .Project.Feature.Settings.Domain,
        ])
    )
).project
