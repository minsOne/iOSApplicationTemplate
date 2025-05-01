import ProjectDescription
import ProjectDescriptionHelpers

let project = FrameworkTemplate(
    name: "SharedThirdPartyLibraryManager",
    target: [
        .framework([.module(.static)]),
    ]
).project
