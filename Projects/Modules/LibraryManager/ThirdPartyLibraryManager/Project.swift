import ProjectDescription
import ProjectDescriptionHelpers

let project = FrameworkTemplate(
    name: "ThirdPartyLibraryManager",
    packages: [
        .Alamofire,
    ],
    target: [
        .framework([.module(.dynamic)]),
    ],
    configure: .init(
        framework: .init(dependency: [
            .SwiftPM.Alamofire,
            .sdk(name: "sqlite3", type: .library),
            .sdk(name: "StoreKit", type: .framework),
        ] + Dep.Framework.Firebase
        )
    )
).project
