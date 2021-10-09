import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .framework(name: "RxPackage",
               packages: [
                .ReactorKit,
                .RIBs,
                .RxSwift,
               ],
               dependencies: [
                .SwiftPM.ReactorKit,
                .SwiftPM.RIBs,
                .SwiftPM.RxCocoa,
                .SwiftPM.RxRelay,
                .SwiftPM.RxSwift,
               ])
