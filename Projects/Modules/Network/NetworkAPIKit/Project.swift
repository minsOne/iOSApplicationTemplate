import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .deprecatedStaticFramework(
        name: "NetworkAPIKit",
        dependencies: [
            .Project.Module.ThirdPartyLibraryManager,
        ]
    )
