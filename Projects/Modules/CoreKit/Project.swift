import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .framework(name: "CoreKit",
               packages: [
                .ResourcePackage
               ],
               dependencies: [
                .Project.NetworkAPI,
                .Project.UtilityKit,
                .Project.AnalyticsKit,
                .Project.ThirdPartyLibraryManager,
                .SwiftPM.ResourcePackage,
               ],
               hasDemoApp: true)
