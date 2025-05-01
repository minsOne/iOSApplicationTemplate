import ProjectDescription
import ProjectDescriptionHelpers

let project = FrameworkTemplate(
    name: "UIThirdPartyLibraryManager",
    target: [
        .framework([.module(.static)]),
    ]
).project
