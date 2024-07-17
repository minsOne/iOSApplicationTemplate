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
            [.sdk(name: "sqlite3", type: .library),
             .sdk(name: "StoreKit", type: .framework)],
        ].flatMap { $0 }
    )
