import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "MOFoundationKit",
    targets: Set([
       .dynamicFramework,
       .tests,
       .example,
       .testing
    ]),
    dependencies: [
        Dep.Project.Module.Foundation.UtilityKit,
    ]
)
