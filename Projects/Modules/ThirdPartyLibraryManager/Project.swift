import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .framework(name: "ThirdPartyLibraryManager",
               packages: [
                .Alamofire,
                .RIBs,
                .RxSwift,
                .SnapKit
               ],
               dependencies: [
               TargetDependency.Framework.Firebase,
                [.SwiftPM.Alamofire,
                 .SwiftPM.RIBs,
                 .SwiftPM.RxCocoa,
                 .SwiftPM.RxRelay,
                 .SwiftPM.RxSwift,
                 .SwiftPM.SnapKit,
                 ],
                [.sdk(name: "libsqlite3.tbd"),
                 .sdk(name: "StoreKit.framework")],
               ].flatMap { $0 })
