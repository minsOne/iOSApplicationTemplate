import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project
    .framework(name: "ThirdPartyLibraryManager",
               packages: [
                .Alamofire,
                .Swinject,
                .InjectPropertyWrapper
               ],
               dependencies: [
                Dep.Framework.Firebase,
                [.SwiftPM.Alamofire, 
                 .SwiftPM.Swinject,
                 .SwiftPM.InjectPropertyWrapper],
                [.sdk(name: "libsqlite3.tbd"),
                 .sdk(name: "StoreKit.framework")],
               ].flatMap { $0 })
