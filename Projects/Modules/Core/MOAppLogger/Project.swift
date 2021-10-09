import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "MOAppLogger",
    targets: Set([
       .staticframework,
       .tests,
       .example,
       .testing
    ]),
    dependencies: [
        Dep.Project.Module.Core.ThirdPartyLibManager,
    ]
)
