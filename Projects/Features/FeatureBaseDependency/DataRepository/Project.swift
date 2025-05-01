import ProjectDescription
import ProjectDescriptionHelpers

let project = FrameworkTemplate(
    name: "FeatureBaseDependencyDataRepository",
    target: [
        .framework([.module(.static)]),
    ]
).project
