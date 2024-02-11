import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "AnalyticsKit",
                     dependencies: [
                        .Project.Module.ThirdPartyLibraryManager,
                     ])
