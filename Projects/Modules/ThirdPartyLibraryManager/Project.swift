import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .framework(name: "ThirdPartyLibraryManager",
               packages: [
                .Alamofire,
                .ReactorKit,
                .RIBs,
                .RxSwift,
                .SnapKit,
                .Blueprint,
                .FlexLayout,
               ],
               dependencies: [
               TargetDependency.Framework.Firebase,
                [.SwiftPM.Alamofire,
                 .SwiftPM.BlueprintUI,
                 .SwiftPM.BlueprintUICommonControls,
                 .SwiftPM.FlexLayout,
                 .SwiftPM.ReactorKit,
                 .SwiftPM.RIBs,
                 .SwiftPM.RxCocoa,
                 .SwiftPM.RxRelay,
                 .SwiftPM.RxSwift,
                 .SwiftPM.SnapKit,
                 ],
                [.sdk(name: "libsqlite3.tbd"),
                 .sdk(name: "StoreKit.framework")],
               ].flatMap { $0 })
