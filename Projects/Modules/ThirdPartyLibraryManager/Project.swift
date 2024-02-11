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
                Dep.Framework.Firebase,
                [.SwiftPM.Alamofire, 
                 .SwiftPM.Swinject,
                 .SwiftPM.InjectPropertyWrapper],
                [.sdk(name: "libsqlite3.tbd", type: .framework),
                 .sdk(name: "StoreKit.framework", type: .framework)],
               ].flatMap { $0 })
