import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "MONetworkAPIHome",
    targets: Set([
       .staticframework,
       .tests,
       .example,
       .testing
    ]),
    dependencies: [
        Dep.Project.Module.Core.Network.NetworkAPIKit,
    ]
)
