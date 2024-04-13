import ProjectDescription
import ProjectDescriptionHelpers

let project = FrameworkTemplate(
    name: "MOContainer",
    target: [
        .framework([.module(.static)]),
    ],
    configure: .init(
        packageName: .Container
    )
).project
