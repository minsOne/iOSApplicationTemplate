import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .framework(name: "ThirdPartyLibraryManager",
               packages: [
                .Alamofire
               ],
               dependencies: [
                [.SwiftPM.Alamofire],
                [.sdk(name: "libsqlite3.tbd"),
                 .sdk(name: "StoreKit.framework")],
                TargetDependency.Framework.Firebase
               ].flatMap { $0 })
