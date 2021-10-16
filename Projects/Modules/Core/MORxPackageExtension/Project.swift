import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "MORxPackageExtension",
    targets: Set([
       .dynamicframework,
       .tests,
       .example,
       .testing
    ]),
    dependencies: [
        Dep.Framework.Common.ReactorKit,
        [
            Dep.Framework.Common.RIBs,
            Dep.Framework.Common.RxCocoa,
            Dep.Framework.Common.RxRelay,
            Dep.Framework.Common.RxSwift,
        ]
    ].flatMap { $0 }
)
