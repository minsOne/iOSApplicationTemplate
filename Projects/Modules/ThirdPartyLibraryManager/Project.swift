import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .framework(name: "ThirdPartyLibraryManager",
               packages: [
                .Alamofire,
                .Swinject,
                .InjectPropertyWrapper
               ],
               dependencies: [
                TargetDependency.Framework.Firebase,
                [.SwiftPM.Alamofire, 
                 .SwiftPM.Swinject,
                 .SwiftPM.InjectPropertyWrapper],
                [.sdk(name: "libsqlite3.tbd"),
                 .sdk(name: "StoreKit.framework")],
               ].flatMap { $0 })
