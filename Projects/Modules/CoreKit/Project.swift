import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .framework(name: "CoreKit",
               packages: [
                .ProxyResourcePackage
               ],
               dependencies: [
                .Project.NetworkAPIs,
                .Project.UtilityKit,
                .Project.AnalyticsKit,
                .Project.ThirdPartyLibraryManager,
                .SwiftPM.ProxyResourcePackage,
               ],
               hasDemoApp: true)
