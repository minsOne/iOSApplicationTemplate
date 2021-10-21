import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "MOThirdPartyLibManager",
    targets: Set([
       .dynamicFramework,
       .tests,
       .example,
       .testing
    ]),
    packages: [
        .Alamofire,
        .Swinject,
        .InjectPropertyWrapper
    ],
    dependencies: [
        Dep.Framework.Vendor.Firebase,
        [
            .SwiftPM.Alamofire,
            .SwiftPM.Swinject,
            .SwiftPM.InjectPropertyWrapper
        ],
        [
            .sdk(name: "libsqlite3.tbd"),
            .sdk(name: "StoreKit.framework"),
            .sdk(name: "libc++.tbd")
        ],
    ].flatMap { $0 }
)
