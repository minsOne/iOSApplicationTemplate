import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .deprecatedFramework(
        name: "ThirdPartyLibraryManager",
        packages: [
            .Alamofire,
        ],
        dependencies: [
            Dep.Framework.Firebase,
            [.SwiftPM.Alamofire],
            [.sdk(name: "libsqlite3.tbd", type: .framework),
             .sdk(name: "StoreKit.framework", type: .framework)],
        ].flatMap { $0 }
    )
