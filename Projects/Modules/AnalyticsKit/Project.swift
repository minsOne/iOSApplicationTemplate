import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .deprecatedStaticFramework(
        name: "AnalyticsKit",
        dependencies: [
            .Project.Module.ThirdPartyLibraryManager,
        ]
    )
