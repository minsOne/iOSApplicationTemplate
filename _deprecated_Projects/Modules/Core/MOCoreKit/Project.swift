import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "MOCoreKit",
    targets: Set([
       .dynamicframework,
       .tests,
       .example,
       .testing
    ]),
    dependencies: [
        Dep.Project.Module.Foundation.FoundationKit,
    ]
)
