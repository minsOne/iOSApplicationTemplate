import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "MOContainer",
    target: [
        .framework([.module(.static)]),
    ],
    configure: .init(
        framework: .init(
            module: .init(packageName: "Container")
        )
    )
)
