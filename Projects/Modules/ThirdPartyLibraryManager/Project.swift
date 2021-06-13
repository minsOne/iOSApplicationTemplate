import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .framework(name: "ThirdPartyLibraryManager",
               packages: [
                .Alamofire,
                .RxSwift,
                .SnapKit
               ],
               dependencies: [
               TargetDependency.Framework.Firebase,
                [.SwiftPM.Alamofire,
                 .SwiftPM.RxCocoa,
                 .SwiftPM.RxRelay,
                 .SwiftPM.RxSwift,
                 .SwiftPM.SnapKit,
                 ],
                [.sdk(name: "libsqlite3.tbd"),
                 .sdk(name: "StoreKit.framework")],
               ].flatMap { $0 })
