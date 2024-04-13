import ProjectDescription
import ProjectDescriptionHelpers

let project = FrameworkTemplate(
    name: "MOFoundationKit",
    target: [
        .framework([.module(.static)]),
    ],
    dependencies: [
        .Project.Module.Foundation.Container,
    ]
).project
