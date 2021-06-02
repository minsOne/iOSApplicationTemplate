import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .framework(name: "CoreKit",
               dependencies: [
                .Project.NetworkAPI,
                .Project.UtilityKit,
                .Project.ResourceManager,
                .Project.AnalyticsKit,
                .Project.ThirdPartyLibraryManager,
               ],
               hasDemoApp: true)
