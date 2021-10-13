import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "RxPackage",
    targets: Set([
       .dynamicframework,
       .tests,
       .example,
       .testing
    ]),
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
    ]
)
