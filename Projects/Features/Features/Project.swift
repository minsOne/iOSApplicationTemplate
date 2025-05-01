import ProjectDescription
import ProjectDescriptionHelpers

let project = FrameworkTemplate(
    name: "Features",
    target: [
        .framework([.module(.dynamic)]),
    ]
).project
