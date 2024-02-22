import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(
    name: "MOContainer",
    target: [
        .framework([.module(.static)]),
    ]
)
