import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "MONetworkAPIs",
    targets: Set([
       .staticLibrary,
       .tests,
       .example,
       .testing
    ]),
    dependencies: [
        Dep.Project.Module.Core.Network.NetworkAPICommon,
        Dep.Project.Module.Core.Network.NetworkAPIHome,
        Dep.Project.Module.Core.Network.NetworkAPILogin,
    ]
)
