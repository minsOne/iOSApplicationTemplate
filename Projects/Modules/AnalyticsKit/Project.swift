import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project
    .staticFramework(name: "AnalyticsKit",
                     dependencies: [
                        .Project.ThirdPartyLibraryManager,
                     ])
