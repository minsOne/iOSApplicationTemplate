import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .framework(name: "CoreKit",
               dependencies: [
                .Project.Network.APIs,
                .Project.Module.UtilityKit,
                .Project.Module.RxPackage,
                .Project.Module.AnalyticsKit,
                .Project.Module.ThirdPartyLibraryManager,
               ],
               hasDemoApp: true)
