import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "MOFoundationKit",
    target: [
        .framework([.module(.static)]),
    ],
    dependencies: [
        .Project.Module.Foundation.Container,
    ]
)
